# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    subject Faker::Lorem.word
    body Faker::Lorem.sentence(4)
    name Faker::Name.name
    email Faker::Internet.email
  end
end
