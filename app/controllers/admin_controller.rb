class AdminController < ApplicationController

  before_filter :check_admin?

  def settings
    @settings = TavernaPlayerPortal.settings
  end

  def update_settings
    TavernaPlayerPortal.settings_manager.hash.merge!(params[:settings])
    TavernaPlayerPortal.settings_manager.save
    @settings = TavernaPlayerPortal.settings

    flash[:notice] = "Settings updated"
    redirect_to admin_settings_path
  end

  private

  def check_admin?
    authorize(user_signed_in? && current_user.admin?)
  end

end
