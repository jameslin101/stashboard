require 'spec_helper'

describe "test status requests" do
  
  context "when logged in", :js => true do
    
    before(:each) do
      login_user
      name = Faker::Lorem.word
      desc = Faker::Lorem.sentence
      create_service(name, desc)
    end
    
    it "should be able to create a status"  do
      msg = Faker::Lorem.sentence
      create_status(msg)
      confirm_string = "New status " + msg + " created."
      page.should have_content confirm_string
      page.should have_content msg
    end  

    it "should be able to edit a service"  do
      msg = Faker::Lorem.sentence
      create_status(msg)
      visit services_path
      click_link "[Statuses]"
      click_link "[Edit]"

      msg2 = Faker::Lorem.sentence
      fill_in "status_message", with: msg2     
      click_on "Update Status"
      sleep 3
      confirm_string = msg2 + " status updated."

      page.should have_content confirm_string
    end    
  
    it "should be able to delete a service"  do
      msg = Faker::Lorem.sentence
      create_status(msg)
      visit services_path
      click_link "[Statuses]"
      page.evaluate_script('window.confirm = function() { return true; }')
      #page.click('Remove')
      click_link "[Delete]"
      sleep 3
      confirm_string = msg + " status destroyed."
      page.should have_content confirm_string

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
