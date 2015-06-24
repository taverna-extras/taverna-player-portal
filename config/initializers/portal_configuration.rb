require 'taverna_player_portal/settings'
require 'taverna_player_portal/settings_manager'
require 'taverna_player_portal/dummy_settings_manager'

if Rails.env.test?
  TavernaPlayerPortal.settings_manager = TavernaPlayerPortal::DummySettingsManager.new
else
  TavernaPlayerPortal.settings_manager = TavernaPlayerPortal::SettingsManager.new
end

TavernaPlayerPortal.settings_manager.load
