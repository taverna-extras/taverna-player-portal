class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :configure_permitted_devise_params, if: :devise_controller?

  protected

  def configure_permitted_devise_params
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def authorize(condition)
    unless condition
      render 'errors/unauthorized', :status => :unauthorized
    end
  end

  def can?(action, object)
    user_signed_in? && current_user.can?(action, object)
  end

end
