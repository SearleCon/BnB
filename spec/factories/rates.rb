# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rate do
    active true
    description Faker::Lorem.sentence(4)
    price 20
  end
end
