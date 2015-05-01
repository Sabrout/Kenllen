FactoryGirl.define do
  factory :user do
    sequence(:fname) { |n| "mike#{n}"}
    sequence(:lname) { |n| "John#{n}"}
    sequence(:uname) { |n| "DoeUser#{n}"}
    sequence(:email) { |n| "mike#{n}@awesome.com"}
    password "password"
    phone 123456
    reports 0
    banned false
    after(:build) do |u|
        u.skip_confirmation!
    end
  end
end