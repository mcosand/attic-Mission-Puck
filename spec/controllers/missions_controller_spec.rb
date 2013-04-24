require 'spec_helper'

describe MissionsController, :type => :controller do
  before do
    controller.enable_broadcast = false
  end

  it "should return a list of missions" do
    get :mostrecent, :id => 6, :format => :json
  end

  it "should create a json based on supplied JSON" do
    args =  { :title => 'JSON Mission', :started => Time.now }

    controller.should_receive(:broadcast).exactly(1).times

    post :create, :format => :json, :mission => args
    jsonResult = JSON.parse(response.body)
    m = Mission.find(jsonResult['id'])

    response.status.should == 200
    m.title.should == args[:title]
  end

  it "should update a mission based on JSON" do
    m = FactoryGirl.create(:mission)
    args = { :title => 'Updated Title' }

    post :update, :format => :json, :id => m.id.as_json, :mission => args

    updated = Mission.find(m.id)

    if (response.status == 422) then puts response.body.inspect end
    response.status.should == 200
    updated.title.should == args[:title]    

  end

  it "should fetch a mission [json]" do
    m = FactoryGirl.create(:mission)
    get :show, :format => :json, :id => m.id.as_json
    response.status.should == 200

    json_m = JSON.parse(response.body)
    json_m['title'].should == m.title
  end

  it "should destroy a mission" do
    m = FactoryGirl.create(:mission)
    post :destroy, :format => :json, :id => m.id.as_json

    response.status.should == 200
  end
end
