require 'spec_helper'

describe MissionsController, :type => :controller do
  context '#mostrecent' do

    before(:all) do
      create(:mission, title: 'first', started: 1000.seconds.ago )
      create(:mission, title: 'second', started: 100.seconds.ago )
      create(:mission, title: 'third', started: 10.seconds.ago )
    end

    after(:all) do
      Mission.delete_all
    end

    context "by default" do

      it "returns one mission" do
        get :mostrecent, :format => :json
        missions = JSON.parse(response.body)
        missions.size.should eq 1
      end

      it "returns most recent mission" do
        get :mostrecent, :format => :json
        missions = JSON.parse(response.body)
        missions[0]['title'].should eq 'third'
      end

    end

    it "can return subset" do
      get :mostrecent, :id => 2, :format => :json
      missions = JSON.parse(response.body)
      missions.size.should eq 2
    end

    it "returns ordered list" do
      get :mostrecent, :id => 3, :format => :json
      missions = JSON.parse(response.body)
      (missions[1]['started'] > missions[2]['started']).should be_true
    end

    it "can return all missions" do
      num_missions = Mission.count
      get :mostrecent, :id => num_missions + 1, :format => :json
      missions = JSON.parse(response.body)
      missions.size.should eq num_missions
    end

  end
end