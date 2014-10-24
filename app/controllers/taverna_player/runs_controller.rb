#------------------------------------------------------------------------------
# Copyright (c) 2013 The University of Manchester, UK.
#
# BSD Licenced. See LICENCE.rdoc for details.
#
# Taverna Player was developed in the BioVeL project, funded by the European
# Commission 7th Framework Programme (FP7), through grant agreement
# number 283359.
#
# Author: Robert Haines
#------------------------------------------------------------------------------

class TavernaPlayer::RunsController < ApplicationController
  # Do not remove the next line.
  include TavernaPlayer::Concerns::Controllers::RunsController

  # Extend the RunsController here.

  private

  alias_method :old_find_run, :find_run

  def update_params
    params.require(:run).permit(:name, :policy_attributes => [:id, :public_permissions => []])
  end

  def run_params
    params.require(:run).permit(
      :create_time, :delayed_job, :embedded, :finish_time, :inputs_attributes,
      :log, :name, :parent_id, :results, :run_id, :start_time,
      :status_message_key, :user_id, :workflow_id,
      :inputs_attributes => [:depth, :file, :metadata, :name, :value],
      :policy_attributes => [:id, :public_permissions => []]
    )
  end

  def find_runs
    select = { :embedded => false }
    select[:workflow_id] = params[:workflow_id] if params[:workflow_id]
    @runs = TavernaPlayer::Run.where(select).order("created_at DESC").with_permissions(current_user, :view).page(params[:page])
  end

  def find_run
    old_find_run
    authorize(@run.can?(current_user, action_name))
  end
end
