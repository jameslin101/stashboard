require 'spec_helper'

describe Status do
  
  before(:each) do
    @user = Factory(:user)
    @service = Factory(:service, :user => @user)
    @attr = {time: Time.now, state: "Up", message: "test"}
    @status = Factory(:status, :service => @service)
  end
  
  it "should create a new status given valid attributes" do
    @service.statuses.create!(@attr)
  end
  
  it "service associations" do
    @status = @service.statuses.create(@attr)
  end
  
  it "should have a service attribute" do
    @status.should respond_to(:service)
  end
  
  it "should have the right associated user" do 
    @status.service_id.should == @service.id
    @status.service.should == @service
  end

  #it "can be created with a time, state, message, and service_id" do
  #  @user.create({time: Time.now, state: "up", message: "test"}).should be_valid
  #end

  it "cannot be created without inputs" do
    Status.new.should_not be_valid
  end
  
end
