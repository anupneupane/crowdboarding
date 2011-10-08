require 'spec_helper'

describe "Events" do
  before :each do
    create_user_and_login!
  end
  describe "GET /events" do
    it "displays the events" do
      Factory(:event, :name => "Friday Retiro")
      visit events_path
      page.should have_content("Friday Retiro")
    end
  end
  
  describe "POST /tasks" do
    it "creates a valid event" do
      Factory(:country)
      click_link "Add Event"
      fill_in "Name", :with => "Friday Retiro"
      select "Spain", :from => "Country"
      fill_in "City", :with => "Madrid"
      fill_in "Street", :with => "Calle Alcala 177 7B"
      fill_in "Contact details", :with => "1234567890"
      fill_in "Tag tokens", :with => "Retiro Longboard"
      fill_in "Enter Date", :with => "2020-06-24"
      click_button "Create Event"
      
      within('div.event') do
        find('h2').should have_content('Friday Retiro')
        find('h2').should have_link('edit')
      end
    end
    
    it "creates an invalid event" do
      click_link "Add Event"
      click_button "Create Event"
      page.should have_content("An error occured")
      page.should have_content("Name can't be blank")
    end
  end
  
  describe "Search" do
    before :each do
      # Making some events in Spain (Default country factory is Spain and city is Madrid)
      @city = Factory(:city)
      @country = Factory(:country, :name => "Spain")
      3.times { Factory(:event, :name => "Friday Retiro", :city => @city, :country => @country) }
      @country2 = Factory(:country, :name => "Netherlands")
      @city2 = Factory(:city, :name => "Amsterdam", :country => @country2)
      2.times { Factory(:event, :name => "Friday Amsterdam", :city => @city2, :country => @country2) }
    end
    
    it "should have 3 events when searching Retiro" do
      visit events_path
      page.should have_content("Events in")
      select('Spain', :from => 'Country')
      click_button('Search')
      page.should have_content("Friday Retiro")
    end
    
    it "should have 2 products when searching Amsterdam" do
      visit events_path
      select('Netherlands', :from => 'Country')
      click_button('Search')
      page.should have_content("Friday Amsterdam")
    end
  end
end
