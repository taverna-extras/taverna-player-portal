require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  test "get runs for user" do
    @routes = TavernaPlayerPortal::Application.routes
    run = create(:run)
    sign_in run.user
    get :runs, user_id: run.user.id, :format => "json"

    assert_not_nil assigns(:runs)
    assert_not_empty assigns(:runs)
    assert_response :success
  end

  test "should be no runs if not signed in" do
    @routes = TavernaPlayerPortal::Application.routes
    run = create(:run)
    #sign_in run.user
    get :runs, user_id: run.user.id, :format => "json"

    assert_not_nil assigns(:runs)
    assert_empty assigns(:runs)
    assert_response :success
  end

end
