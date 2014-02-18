class WorkflowsController < ApplicationController

  def new
    @workflow = Workflow.new
  end

  def create
    @workflow = Workflow.new(workflow_params)
  end

  private

  def workflow_params
    params.require(:workflow).permit(:document)
  end

end
