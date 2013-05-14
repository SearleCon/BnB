# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
    description Faker::Lorem.sentence(4)
  end
end
