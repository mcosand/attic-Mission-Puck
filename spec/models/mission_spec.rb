require 'spec_helper'

describe Mission do

  it 'can be instantiated' do
    Mission.new.should be_an_instance_of(Mission)
  end

  it "should have a valid factory" do
    build(:mission).should be_valid
  end

  it "should require a title" do
    build(:mission, :title => "").should_not be_valid
  end
end
