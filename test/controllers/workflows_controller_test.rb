require 'test_helper'

class WorkflowsControllerTest < ActionController::TestCase
  test "should get create form" do
    sign_in create(:user)
    get :new

    assert_response :success
  end

  test "shouldn't get create form for anonymous users" do
    get :new

    assert_response :unauthorized
  end

  test "should get edit form" do
    workflow = create(:workflow)
    sign_in workflow.user

    get :edit, :id => workflow.id

    assert_response :success
  end

  test "shouldn't get edit form if unauthorized" do
    workflow = create(:workflow)

    get :edit, :id => workflow.id

    assert_response :unauthorized
  end

  test "should get edit form if admin" do
    workflow = create(:workflow)
    sign_in create(:admin)

    get :edit, :id => workflow.id

    assert_response :success
  end

  test "should create workflow" do
    user = create(:user)
    sign_in user

    post :create, :workflow => {:document => fixture_file_upload('files/various_type_outputs.t2flow',
                                                                 'application/octet-stream') }

    assert_redirected_to assigns(:workflow)
    assert_empty assigns(:workflow).errors
  end

  test "should update workflow" do
    workflow = create(:workflow)
    sign_in workflow.user

    patch :update, :id => workflow.id, :workflow => {:title => 'New title'}

    assert_redirected_to workflow_url(workflow)
    assert_equal 'New title', assigns(:workflow).title
  end

  test "shouldn't update workflow if unauthorized" do
    workflow = create(:workflow)
    sign_in create(:user)

    old_title = workflow.title

    patch :update, :id => workflow.id, :workflow => {:title => 'New title'}

    assert_response :unauthorized
    assert_equal old_title, assigns(:workflow).title
  end

  test "should update workflow if admin" do
    workflow = create(:workflow)
    sign_in create(:admin)

    patch :update, :id => workflow.id, :workflow => {:title => 'New title'}

    assert_redirected_to workflow_url(workflow)
    assert_equal 'New title', assigns(:workflow).title
  end

  test "should delete workflow" do
    workflow = create(:workflow)
    sign_in workflow.user

    delete :destroy, :id => workflow.id

    assert_redirected_to workflows_url
  end

  test "shouldn't delete workflow if unauthorized" do
    workflow = create(:workflow)
    sign_in create(:user)

    delete :destroy, :id => workflow.id

    assert_response :unauthorized
  end

  test "should delete workflow if admin" do
    workflow = create(:workflow)
    sign_in create(:admin)

    delete :destroy, :id => workflow.id

    assert_redirected_to workflows_url
  end

  test "should show public workflow" do
    workflow = create(:workflow)
    sign_in create(:user)

    get :show, :id => workflow

    assert_response :success
  end

  test "shouldn't show private workflow" do
    workflow = create(:private_workflow)
    sign_in create(:user)

    get :show, :id => workflow

    assert_response :unauthorized
  end

  test "should show private workflow if explicitly shared" do
    workflow = create(:private_workflow, :policy => create(:private_policy_with_permission))
    shared_with = workflow.policy.permissions.first.subject

    sign_in shared_with

    get :show, :id => workflow

    assert_response :success
  end

  test "shouldn't list private workflows in index" do
    private = FactoryGirl.create_list(:private_workflow, 5)
    FactoryGirl.create_list(:workflow, 5)
    sign_in create(:user)

    get :index

    assert_response :success
    assert_equal 5, assigns(:workflows).count
    assert_empty private & assigns(:workflows), "Workflow set shouldn't contain any private workflows"
  end

end
