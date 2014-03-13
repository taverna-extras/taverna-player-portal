require 'test_helper'

class UsersTest < ActiveSupport::TestCase

  test "can create user" do
    user = build(:user)
    assert user.save
  end

end
