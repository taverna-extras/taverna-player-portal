class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :configure_permitted_devise_params, if: :devise_controller?

  def runs
    @runs = TavernaPlayer::Run.where(:user => params[:user_id]).order('created_at DESC').with_permissions(current_user, :view).page(params[:page])
    respond_to do |format|
      format.json { render json: @runs}
      format.xml { render xml: @runs}
    end

  end

  protected

  def check_logged_in?
    authorize(user_signed_in?)
  end

  def configure_permitted_devise_params
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def authorize(condition)
    unless condition
      render 'errors/unauthorized', status: :unauthorized
    end
  end

  def can?(action, object)
    user_signed_in? && current_user.can?(action, object)
  end

end
