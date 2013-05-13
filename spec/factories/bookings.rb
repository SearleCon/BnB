# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    active true
    online false
    guest
    event
    bnb
  end
end
