FactoryGirl.define do
  factory :user do
    fname "John"
    lname  "Doe"
    email "test@test.com"
    uname "userJohn"
    password "password"
    phone 123456
  end
end