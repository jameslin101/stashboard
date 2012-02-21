require 'spec_helper'

describe ServicesController do
  render_views
  
  describe "Get 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "Get 'show'" do
    before do
      Factory(:service)
    end
    it "should be successful" do
      get :show, id: Service.first.id
      response.should be_success
    end
  end

  
  describe "Post 'create'" do    

      before(:each) do
        @attr = {:name => "", :desc=>""}
      end
      
      it "should not create a service" do
        lambda do
          post :create, :service => @attr
        end.should_not change(Service, :count)
      end
      
      it "should render the 'new' service page" do
        post :create, :service => @attr
        response.should redirect_to(new_service_path)
      end
    
  end
end


