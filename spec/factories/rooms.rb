# Read about factories at https://github.com/thoughtbot/factory_girl


FactoryGirl.define do
  factory :room do
    description "Room Description"
    en_suite false
    rates 1.0
    extras "Extras"
    sequence (:room_number)
    available true
    capacity 1
  end
end
