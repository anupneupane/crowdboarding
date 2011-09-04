namespace :db do
  desc "Erase and fill database with dummy data"
  task :fill_database => :environment do
    require 'populator'
    require 'faker'
    
    [Event, User, Country, Tag].each(&:delete_all)    
    
    Country.create!(:name => "Spain", :country_code => "es")
    
    Tag.create!(:name => "Longboard")
    Tag.create!(:name => "Retiro")
    Tag.create!(:name => "Skateboard")
    
    User.populate 100 do |user|
      user.name = Faker::Name.name
      user.nickname = Faker::Name.name
      user.email = Faker::Internet.email
      user.encrypted_password = "bleh :)"
      user.bio = Populator.paragraphs(1..2)
      user.quiver = Populator.paragraphs(1..2)
      user.birthdate = 52.years.ago..18.years.ago
      user.default_city_id = (rand * City.count).to_i
      user.profile_views = 0..200      
    end
    
    Event.populate 100 do |event|
      event.name = Populator.words(1..3).titleize
      event.country_id = Country.first.id
      event.created_at = 2.years.ago..Time.now
      event.starts_at = 1.weeks.ago..1.weeks.from_now
      event.user_id = (rand * User.count).to_i
      event.city_id = 1
      event.description = Populator.paragraphs(1..3)
      event.address = Faker::Address.street_address
      event.lat = (rand(-100000) / -100000.0)
      event.lng = (rand(-100000) / -100000.0)
      event.users_count = 1..40
    end
    
    Event.all.each do |event|
      event.tag_list = Tag.all[rand * 3].name
      event.save
    end
  end
end