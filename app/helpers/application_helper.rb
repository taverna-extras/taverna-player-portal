module ApplicationHelper

  def can?(action, object)
    object.can?(current_user, action)
  end

end
