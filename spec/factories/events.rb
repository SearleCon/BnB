# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "Booking"
    start_at Date.today
    end_at Date.tomorrow
    color 'blue'
  end
end
