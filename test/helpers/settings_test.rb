require 'test_helper'

class SettingsTest < ActiveSupport::TestCase

  def setup
    TavernaPlayerPortal.settings_manager.reset
  end

  test "can access settings" do
    assert !TavernaPlayerPortal.settings.nil?
    assert_equal "Taverna Player Portal", TavernaPlayerPortal.settings.portal_name
  end

end
