require 'test_helper'

class UsersTest < ActiveSupport::TestCase

  test "can create user" do
    user = build(:user)
    assert user.save
  end

  test "first user is admin" do
    first_user = create(:user)
    second_user = create(:user)

    assert first_user.admin?
    assert !second_user.admin?
  end

end
