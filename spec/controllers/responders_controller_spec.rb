require 'spec_helper'
require 'rspec/rails'

describe RespondersController, :type => :controller do
  before do
    @mission = FactoryGirl.create(:mission)
    controller.enable_broadcast = false

    cmd = Commands::UpdateResponderStatusCommand.make(@mission.id, {
        'responder' => { 'firstname' => 'Charlie', 'last' => 'Brown' },
        'unit' => { 'name' => 'ABC' },
        'time' => Time.now, 'status' => :signedin, 'role' => :field })
    cmd.execute

    unit = cmd.unit.id
    @people = {:charlie => cmd.responder }

    cmd = Commands::UpdateResponderStatusCommand.make(@mission.id, {
        'responder' => {'firstname' => 'Mary', 'last' => 'Jones' },
        'unit_id' => unit.id,
        'time' => Time.now, 'status' => :signedin, 'role' => :field })
    cmd.execute

    cmd.responder.should_not == nil
    @people[:mary] = cmd.responder

    cmd = Commands::UpdateCommand.make(nil, 'Team', { 'name' => 'Alpha', 'mission_id' => @mission.id })
    cmd.execute
  end

  it 'should assign responder to base support' do
    base = @mission.teams.select{|t| t.kind == :base}[0]

    put :team, :id => @people[:mary].id.as_json, :mission_id => @mission.id.as_json, :team_id => base.id, :format => :json

    response.status.should == 200

    base = Team.find(base.id)
    base.members.count.should == 1
    r = base.members[0]
    r.id.should == @people[:mary].id
    r.current.status.should == :assigned
  end

  it 'should create new team when assigning member' do
    put :team, :id => @people[:mary].id.as_json, :mission_id => @mission.id.as_json, :team_id => '', :format => :json, :team => { 'name' => 'Test team' }

    response.status.should == 200

  end
end
