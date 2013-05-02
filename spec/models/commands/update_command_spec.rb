require 'spec_helper'

describe Commands::UpdateCommand do
  it "should create an object if it doesn't exist" do
    m = FactoryGirl.build(:mission)    
    cmd = Commands::UpdateCommand.make(nil, 'Mission', m.attributes)

    prev_count = Mission.count

    cmd.execute

    cmd.reference.should_not == nil
    Mission.count.should == prev_count + 1
    Mission.find(cmd.reference).title.should == m.title
  end

  it "should be recorded in the command log" do
    m = FactoryGirl.build(:mission)
    cmd = Commands::UpdateCommand.make(nil, 'Mission', m.attributes)

    prev_count = Commands::Command.count
    cmd.execute
    Commands::Command.count.should == prev_count + 1
  end

  it "should propogate validation failures" do
    m_attributes = FactoryGirl.build(:mission, :title => "").attributes
    m_attributes['title'] = ''
    cmd = Commands::UpdateCommand.make(nil, 'Mission', m_attributes)

    cmd.execute.should == false
    cmd.model.errors.messages[:title].should_not == nil
  end

  it "should replay child object" do
    m = FactoryGirl.create(:mission)
    cmd = Commands::UpdateCommand.new({
      :reference => '04133501-1538-4e16-a30c-0b45d0840b98',
      :data => {
        'type' => 'Log',
        'data' => {
          'id' => '04133501-1538-4e16-a30c-0b45d0840b98',
          'message' => 'Test Message',
          'when' => Time.now - 100,
          'mission_id' => m.id.as_json
        }
      }
    })
    cmd.is_replay = true
    cmd.execute

    m = Mission.find(m.id)
    m.logs.count.should == 1
    Commands::Command.count.should == 0
  end

  it "should be able to replay object with complex initial state" do
    cmd = Commands::UpdateCommand.new({
      :reference => '8993a143-fe96-41f3-a1d5-2fde4bc349f7',
      :data => {
        'type' => 'Mission',
        'data' => {
          'id' => '8993a143-fe96-41f3-a1d5-2fde4bc349f7',
          'title' => 'Hydrated mission',
          'started' => Time.now - 3600,
        },
        'child_keys' => {
          'base_id' => 'e4cfcad4-c8e8-4713-80b5-1aad4edb6206',
          'staging_id' => '521e5368-e495-43f7-969d-741740e0b5bc' 
        }
      }
    })
    cmd.is_replay = true
    cmd.execute

    m = Mission.find('8993a143-fe96-41f3-a1d5-2fde4bc349f7')
    m.teams.count.should == 2
    m.teams.select{|f| f.id.as_json == 'e4cfcad4-c8e8-4713-80b5-1aad4edb6206'}.should_not be_empty
    Commands::Command.count.should == 0
  end
end
