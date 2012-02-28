require 'spec_helper'

describe "LayoutLinks" do
#  describe "GET /layout_links" do
  context "layout links", :js => true do
    it "should have a Home page at '/'" do
      visit '/'
      # within("title") { page.should have_content "Services Home" }
      page.find("title").should have_content "Services Home"
      # response.should have_selector('.title', :content => 'Services Home')
    end
  end
    
#  end
end
