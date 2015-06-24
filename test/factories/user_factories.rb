FactoryGirl.define do
  factory :user do
    name "John Doe"
    email
    password "12345678xyz"
    password_confirmation "12345678xyz"
  end

  factory :admin, :parent => :user do
    name "Adam Ministrator"
    admin true
  end

  factory :non_admin, :parent => :user do
    name "Simple Simon"
    admin false
  end
end
