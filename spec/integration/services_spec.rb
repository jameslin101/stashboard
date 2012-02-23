require 'spec_helper'

describe "test service requests" do
  before(:each) do
    @user = Factory(:user)
    @service = Factory(:service, :user => @user)
  end

  context "when logged out" do
    it "should not be able to edit services", :js => true do
      visit "/"
      # visit edit_service_path(@service.id)
      current_path.should == sign_in_path
    end
  end
  
  context "when logged in" do
    before do
      user = Factory(:user)
      #service = Factory(:service, :user => user)
      sign_in_as(user)
    end
    it "should be able to create a service" do
      # From homepage, see post listing
      visit root_path
      click_link "[Add service]"

      page.current_path.should == new_service_path
      page.should have_content "New Service"

      page.current_path.should == new_post_path
      name = Faker::Lorem.word
      desc = Faker::Lorem.sentence

      fill_in "Name", with: title
      fill_in "Description", with: desc

      # Assert that post is actually created with desired content
      expect {
        click_on "Create"
      }.to change { Service.count }.by(1)

      #post = Post.last
      #page.current_path.should == post_path(post)
      #page.should have_content content
      #page.should have_content title

      # Assert that we can return to post listings
      #click_on "see posts"
      #page.current_path.should == posts_path
    end
  end
end
#describe "Services" do
#describe "GET /services" do
#  it "works! (now write some real specs)" do
    # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#    get services_index_path
#    response.status.should be(200)
#  end
#end
#end
