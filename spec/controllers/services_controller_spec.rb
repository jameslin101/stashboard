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

end
