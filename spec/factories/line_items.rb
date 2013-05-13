FactoryGirl.define do
  factory :line_item do
    description Faker::Lorem.sentence(2)
    value 100
  end
end

