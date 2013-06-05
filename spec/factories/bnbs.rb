# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :bnb do
    name 'Test Bnb'
    description {Faker::Lorem.sentence(4)}
    email {Faker::Internet.email}
    address_line_one {Faker::Address.street_address}
    address_line_two {Faker::Address.secondary_address}
    city {Faker::Address.city}
    region {Faker::Address.state}
    postal_code {Faker::Address.postcode}
    country {Faker::Address.country}
    telephone_number {Faker::PhoneNumber.phone_number}
    website {Faker::Internet.domain_name}
    contact_person {Faker::Name.name}
    twitter_account '@TestBnb'
    rating 4
    facebook_page 'www.facebook.com/TestBnb'
    approved true
    user_id 1

    trait :valid_address do
      address_line_one {'25 Lukin Rd'}
      address_line_two { 'Selborne' }
      city { 'East London' }
      region { 'Eastern Cape' }
      postal_code { '5201' }
      country {'South Africa'}
      latitude '-32.994557'
      longitude '27.904022'
      mappable true
    end
  end


end


