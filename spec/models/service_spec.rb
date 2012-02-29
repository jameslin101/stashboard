require 'spec_helper'

describe Service do
  describe "factories" do
    it "should have a valid factory" do
      Factory.build(:service).should be_valid
    end
  end
  

  before(:each) do
    @user = Factory(:user)
    @attr = {:name => "newservice"}
    @service = Factory(:service, :user => @user)
  end
  
  it "should create a new instance given valid attributes" do
    @user.services.create!(@attr)
  end
  
  it "user associations" do
    @service = @user.services.create(@attr)
  end
  
  it "should have a user attribute" do
    @service.should respond_to(:user)
  end
  
  it "should have the right associated user" do 
    @service.user_id.should == @user.id
    @service.user.should == @user
  end
  
#  it "can be created with a name" do
#    Service.new({name: "newservice"}).should be_valid
#  end
#  it "cannot be created without a name" do
#    Service.new.should_not be_valid
#  end
end
