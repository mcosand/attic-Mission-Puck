require 'spec_helper'
require 'rspec/rails'

describe RosterTimelinesController, :type => :controller do
  before do
    @mission = FactoryGirl.create(:mission)
#    @mission.id = UUIDTools::UUID.random_create
  end

  it "testJSON" do
    timeline = {:status => :enroute, :role => :field, :time => Time.now }
    responder = {:firstname => 'Joe', :lastname => 'Searcher', :number => 'S-1234'}
    unit = {:name => 'Alpha'}
    post :create, :mission_id => @mission.id.as_json, :format => :json,
      :timeline => timeline, :responder => responder, :unit => unit

    response.status.should == 200

    @mission.responders.length.should == 1
    @mission.responders.first.timeline.size.should == 1
    @mission.responders.first.current.should_not == nil
    @mission.responders.first.current.should == @mission.responders.first.timeline.first
  end

  it "add second timeline" do
  
    responder = @mission.responders.create({:firstname => 'Joe', :lastname => 'Searcher', :number => 'S-1234' })
    unit = @mission.units.create({:name => 'Alpha'})

    first_timeline = responder.timeline.build({:time => Time.now })
    first_timeline.responder = responder
    first_timeline.unit = unit
    first_timeline.status = :enroute
    first_timeline.role = :field
    first_timeline.save!

    timeline = {:status => :signedin, :role => :field, :time => Time.now, :responder_id => responder.id.to_s, :unit_id => unit.id.to_s }
    post :create, :mission_id => @mission.id.as_json, :format => :json,
          :timeline => timeline

    response.status.should == 200

    @mission.responders.length.should == 1
    @mission.units.length.should == 1
    @mission.responders.first.timeline.count.should == 2
  end

end
