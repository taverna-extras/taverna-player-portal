FactoryGirl.define do
  factory :user do
    name "John Doe"
    email "jd@example.fake"
    password "12345678xyz"
    password_confirmation "12345678xyz"
  end
end
