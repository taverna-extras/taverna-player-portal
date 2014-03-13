require 'test_helper'

class RunsTest < ActiveSupport::TestCase

  test "can create run" do
    run = build(:run)

    assert run.save
  end

end
