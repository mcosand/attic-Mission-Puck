require 'spec_helper'

describe Mission do
  it "should have a valid factory" do
    FactoryGirl.build(:mission).should be_valid
  end

  it "should require a title" do
    FactoryGirl.build(:mission, :title => "").should_not be_valid
  end
end
