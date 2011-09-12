require 'spec_helper'

describe Notification do
  before :each do
    create_user_and_login!
    @notification = Factory(:notification, :user => @user, :body => "Lorem ipsum")
  end
  # 
  it "Get index page" do
    visit(notifications_path)
    page.should have_content("Your Notifications")
    page.should have_content("Lorem ipsum")
  end
  
  # describe "Deleting notifications", :js => true do
    # it "deletes a notification", :js => true do
    #   visit(notifications_path)
    #   page.should have_content("Your Notifications")
    #   page.should have_content("Lorem ipsum")
      # click_link("delete_notification_#{@notification.id}")
      # click_button('Ok')
      # page.should_not have_content("Lorem ipsum")
    # end
  # end
end