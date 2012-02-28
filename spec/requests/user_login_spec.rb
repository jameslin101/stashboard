require 'spec_helper'

describe "test logging in" do
  
  before(:each) do
    @user = User.create!(:email => "test@test.com", :password => "password")
  end

  context "when logged out" do

    it "should be able to log in", :js=>true do
      ap @user
      visit sign_in_path
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "password"
      click_button "Sign in"
      page.find(".user").should have_content "test@test.com"
    end
  end
end