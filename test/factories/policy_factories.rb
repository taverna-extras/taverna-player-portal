FactoryGirl.define do

  factory :policy do
    public_permissions :view
  end

  factory :private_policy, :class => Policy do
    public_permissions []
  end

  factory :private_policy_with_permission, :parent => :private_policy do
    after(:create) do |policy|
      create(:user_permission, :policy => policy)
    end
  end

end
