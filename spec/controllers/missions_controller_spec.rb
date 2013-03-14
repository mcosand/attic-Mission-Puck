require 'spec_helper'

describe MissionsController, :type => :controller do
  it "should return a list of missions" do
    get :mostrecent, :id => 6, :format => :json
    puts response.body.inspect
  end
end
