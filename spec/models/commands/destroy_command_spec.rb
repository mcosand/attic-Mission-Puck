require 'spec_helper'

describe Commands::DestroyCommand do
  it "should remove the object" do
    m = FactoryGirl.create(:mission)    
    cmd = Commands::DestroyCommand.make(m.id.as_json, 'Mission')

    cmd.execute.should == true
  end
end
