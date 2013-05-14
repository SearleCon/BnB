# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :suggestion do
    subject 'Test'
    suggestion Faker::Lorem.sentence(4)
    user_id 1
  end
end
