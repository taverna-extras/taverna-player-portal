require 'test_helper'

class RunsControllerTest < ActionController::TestCase

  tests TavernaPlayer::RunsController

  test "should get create form" do
    get :new, :workflow_id => create(:workflow).id, :use_route => :taverna_player

    assert_response :success
  end

  test "should get edit form" do
    run = create(:run)
    sign_in run.user

    get :edit, :id => run.id

    assert_response :success
  end

  test "shouldn't get edit form if unauthorized" do
    run = create(:run)

    get :edit, :id => run.id

    assert_response :unauthorized
  end

  test "should get edit form if admin" do
    run = create(:run)
    sign_in create(:admin)

    get :edit, :id => run.id

    assert_response :success
  end

  test "should create run" do
    user = create(:user)
    sign_in user

    post :create, :run => {:name => 'Test', :workflow_id => create(:workflow).id,
                           :inputs_attributes => [{:name => 'simple_input', :value => 'hello'}]},
         :use_route => :taverna_player

    assert_redirected_to assigns(:run)
    assert_empty assigns(:run).errors
  end

  test "should update run" do
    run = create(:run)
    sign_in run.user

    patch :update, :id => run.id, :run => {:name => 'New title'}

    assert_redirected_to run_url(run)
    assert_equal 'New title', assigns(:run).name
  end

  test "shouldn't update run if unauthorized" do
    run = create(:run)
    sign_in create(:user)

    old_title = run.name

    patch :update, :id => run.id, :run => {:name => 'New title'}

    assert_response :unauthorized
    assert_equal old_title, assigns(:run).name
  end

  test "should update run if admin" do
    run = create(:run)
    sign_in create(:admin)

    patch :update, :id => run.id, :run => {:name => 'New title'}

    assert_redirected_to run_url(run)
    assert_equal 'New title', assigns(:run).name
  end

  test "should delete run" do
    run = create(:run)
    sign_in run.user

    request.env["HTTP_REFERER"] = run_url(run)
    delete :destroy, :id => run.id, :use_route => :taverna_player

    assert_redirected_to run_url(run)
  end

  test "shouldn't delete run if unauthorized" do
    run = create(:run)
    sign_in create(:user)

    delete :destroy, :id => run.id, :use_route => :taverna_player

    assert_response :unauthorized
  end

  test "should delete run if admin" do
    run = create(:run)
    sign_in create(:admin)

    request.env["HTTP_REFERER"] = run_url(run)
    delete :destroy, :id => run.id, :use_route => :taverna_player

    assert_redirected_to run_url(run)
  end

end
