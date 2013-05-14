# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
     paypal_customer_token 'T100'
     paypal_recurring_profile_token 'TP120'
     user_id 1
     association :plan, factory: :plan
     active_profile true
     expiry_date Time.zone.now + 30.days
  end
end
