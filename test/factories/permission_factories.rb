FactoryGirl.define do

  factory :user_permission, :class => Permission do
    association :subject, :factory => :user
    permissions :view
    policy
  end

end
