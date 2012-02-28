require 'spec_helper'

describe "test service requests" do
  
  context "when logged in", :js => true do
    
    before(:each) do
      login_user
    end
    
    it "should be able to create a service"  do
      name = Faker::Lorem.word
      desc = Faker::Lorem.sentence
      create_service(name, desc)
      confirm_string = "New service " + name + " created."
      page.should have_content confirm_string
    end  

    it "should be able to edit a service"  do
      # From homepage, see post listing
      name = Faker::Lorem.word
      desc = Faker::Lorem.sentence
      create_service(name, desc)
      visit services_path
      click_link "[edit]"

      page.should have_content "Edit Service"

      name2 = Faker::Lorem.word
      desc2 = Faker::Lorem.sentence

      fill_in "Name", with: name2
      fill_in "Description", with: desc2
  
      click_on "Edit"
  
      sleep 3
      confirm_string = name2 + " service updated."
      page.should have_content confirm_string
    end    
  
    it "should be able to delete a service"  do
      name = Faker::Lorem.word
      desc = Faker::Lorem.sentence
      create_service(name, desc)
      visit services_path

      #override confirm popup
      page.evaluate_script('window.confirm = function() { return true; }')

      click_link "[delete]"
      sleep 3
      confirm_string = name + " service destroyed."
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
