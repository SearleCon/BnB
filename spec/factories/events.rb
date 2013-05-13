# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "Booking"
    start_at Time.zone.now
    end_at Time.zone.now + 1.day
    color 'blue'
  end
end
