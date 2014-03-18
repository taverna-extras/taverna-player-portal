class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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

end
