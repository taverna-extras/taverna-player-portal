require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  def setup
    TavernaPlayerPortal.settings_manager.reset
  end

  test "should get settings page" do
    sign_in create(:admin)
    get :settings

    assert_response :success
  end

  test "shouldn't get settings page if non-admin" do
    sign_in create(:non_admin)
    get :settings

    assert_response :unauthorized
  end

  test "should update settings if admin" do
    sign_in create(:admin)

    patch :update_settings, settings: {portal_name: 'Fish'}

    assert_redirected_to admin_settings_url
    assert_equal 'Fish', TavernaPlayerPortal.settings.portal_name
  end

  test "shouldn't update settings if non-admin" do
    sign_in create(:non_admin)
    old_name = TavernaPlayerPortal.settings.portal_name

    patch :update_settings, settings: {portal_name: 'Fish'}

    assert_response :unauthorized
    assert_equal old_name, TavernaPlayerPortal.settings.portal_name
  end

end
