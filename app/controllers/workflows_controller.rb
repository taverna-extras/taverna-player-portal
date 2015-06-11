class WorkflowsController < ApplicationController

  before_action :set_workflow_and_auth, :only => [:show, :edit, :update, :destroy, :download]
  before_action :check_logged_in?, :only => [:new, :create]

  def index
    @workflows = Workflow.with_permissions(current_user, :view).page(params[:page])
  end

  def show

  end

  def new
    @workflow = Workflow.new
  end

  def edit

  end

  def download
    send_file @workflow.document.path, :type => Workflow.mime_type, :filename => @workflow.document.original_filename
  end

  def create
    @workflow = Workflow.new(workflow_params)

    respond_to do |format|
      if @workflow.save
        format.html { redirect_to @workflow, notice: 'Workflow was successfully uploaded.' }
        format.json { render action: 'show', status: :created, location: @workflow }
      else
        format.html { render action: 'new' }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @workflow.update(workflow_params)
        format.html { redirect_to @workflow, notice: 'Workflow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @workflow.destroy
    respond_to do |format|
      format.html { redirect_to workflows_url }
      format.json { head :no_content }
    end
  end

  private

  def set_workflow_and_auth
    @workflow = Workflow.find(params[:id])
    authorize(@workflow.can?(current_user, action_name))
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def workflow_params
    p = params.require(:workflow).permit(:document, :title, :description, :policy_attributes => [:id, :public_permissions => []])
    p = p.merge(:user_id => current_user.id) if user_signed_in?
    p
  end
end
