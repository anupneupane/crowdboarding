Factory.define :user do |user|
  user.sequence(:email) { |n| "info#{n}@onlinegeschenkenwinkel.nl" }
  user.password 'secret'
  user.name 'Crowdboarding'
  user.nickname 'crowdboarding'
end

Factory.define :event do |event|
  event.association :user
  event.association :country
  event.association :city
  event.name "Retiro"
  event.starts_at Time.now + 2.weeks
  event.contact_details "1234567890"
  event.street "Calle Alcala 177 7B"
  event.tag_tokens "Retiro Longboard"
end

Factory.define :country do |country|
  country.sequence(:name) { |n| "Spain#{n}"} 
  country.sequence(:country_code) { |n| "e#{n}"} 
end

Factory.define :city do |city|
  city.sequence(:name) { |n| "Madrid#{n}"} 
  city.association :country
end

Factory.define :notification do |notification|
  notification.body "Lorem ipsum"
  notification.association :user
end