FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "info#{n}@onlinegeschenkenwinkel.nl" }
    password 'secret'
    name 'Crowdboarding'
    nickname 'crowdboarding'
  end

  factory :event do
    association :user
    association :country
    association :city
    name "Retiro"
    starts_at Time.now + 2.weeks
    contact_details "1234567890"
    street "Calle Alcala 177 7B"
    tag_tokens "Retiro Longboard"
  end

  factory :country do
    sequence(:name) { |n| "Spain#{n}"} 
    sequence(:country_code) { |n| "e#{n}"} 
  end

  factory :city do
    sequence(:name) { |n| "Madrid#{n}"} 
    association :country
  end

  factory :notification do
    body "Lorem ipsum"
    association :user
  end

end