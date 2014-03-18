module ApplicationHelper

  def can?(action, object)
    user_signed_in? && current_user.can?(action, object)
  end

end
