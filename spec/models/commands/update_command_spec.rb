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
end
