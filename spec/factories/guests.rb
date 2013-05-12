FactoryGirl.define do
  factory :guest do
    name {Faker::Name.first_name}
    surname {Faker::Name.last_name}
    email {Faker::Internet.email}
    contact_number '0123456789'
    bnb
  end
end

