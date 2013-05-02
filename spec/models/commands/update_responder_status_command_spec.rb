require 'spec_helper'

describe Commands::UpdateResponderStatusCommand do
  before do
    @m = FactoryGirl.create(:mission)
    @args =  {'responder' => { 'first' => 'Richard', 'last' => 'Newton' },
            'unit' => { 'name' => 'ABC' },
            'time' => Time.now,
            'status' => :signedin,
            'role' => :field,
           }
  end

  it "should create all objects on new responder" do
    cmd = Commands::UpdateResponderStatusCommand.make(@m.id, @args)
    cmd.execute

    @m = Mission.find(@m.id)
    @m.responders.count.should == 1
    @m.units.count.should == 1
  end

  it "should be able to set the 'status' and 'role' enums" do
    cmd = Commands::UpdateResponderStatusCommand.make(@m.id, @args)
    cmd.execute

    current = cmd.model
    current.status.should == :signedin 
    current.role.should == :field
  end

  it "should handle failures in child objects" do
    @args['unit'] = {} 
    cmd = Commands::UpdateResponderStatusCommand.make(@m.id, @args)

    cmd.execute.should == false
    Responder.count.should == 0
    Unit.count.should == 0
    RosterTimeline.count.should == 0

    cmd.unit.errors.messages[:name].should_not == nil
  end
end
