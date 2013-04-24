require 'spec_helper'

describe LogsController do
  before do
    @mission = FactoryGirl.create(:mission)
    controller.enable_broadcast = false
  end

  it "should create log based on JSON" do
    args = { :message => "Test message", :when => Time.now }
    post :create, :format => :json, :mission_id => @mission.id.as_json, :log => args

    if (response.status == 422) then puts response.body.inspect end
    response.status.should == 200
  end

  it "should destroy a log" do
    m = FactoryGirl.create(:mission)
    l = FactoryGirl.create(:log, :mission => m)
    post :destroy, :format => :json, :mission_id => m.id.as_json, :id => l.id.as_json

    response.status.should == 200
  end

  it "should get the logs for the mission" do
    m = FactoryGirl.create(:mission)
    l = FactoryGirl.create(:log, :mission => m)

    get :index, :format => :json, :mission_id => m.id.as_json

    response.status.should == 200

    result = JSON.parse(response.body)
    result.count.should == 1
  end
end
