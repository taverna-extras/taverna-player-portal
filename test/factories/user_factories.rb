FactoryGirl.define do
  factory :user do
    name "John Doe"
    email
    password "12345678xyz"
    password_confirmation "12345678xyz"
  end

  factory :admin, :parent => :user do
    admin true
  end
end
