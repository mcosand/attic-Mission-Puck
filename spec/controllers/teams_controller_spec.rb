require 'spec_helper'
require 'rspec/rails'

describe TeamsController, :type => :controller do
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

  it 'should return current list of teams' do
    get :index, :mission_id => @mission.id.as_json, :format => :json

    response.status.should == 200
    result = JSON.parse(response.body)
    result['base'].count.should == 1
    result['staging'].count.should == 1
    result['field'].count.should == 1
    result['field'][0]['name'].should == 'Alpha'
  end
end
