FactoryGirl.define do
  factory :user do
    name "John Doe"
    email
    password "12345678xyz"
    password_confirmation "12345678xyz"
  end
end
