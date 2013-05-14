# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    duration 1
    price 100
    active true
    name 'Trial'
    free true
  end
end


