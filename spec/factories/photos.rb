# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    description Faker::Lorem.sentence(3)
    main false
    processed false
    bnb
  end
end
