class Policy < ActiveRecord::Base

  belongs_to :user
  belongs_to :group

  validate :user, :presence => true

  def permits?(user, action)
    mask = Authorization.to_mask([Authorization.privilege_for_action(action)])

    (user && user.admin?) ||
    (self.user == user) && (user_mask & mask != 0) ||
    (user ? user.groups : []).include?(self.group) && (group_mask & mask != 0) ||
    (public_mask & mask != 0)
  end

  def user_permissions
    Authorization.permissions(self.user_mask)
  end

  def group_permissions
    Authorization.permissions(self.group_mask)
  end

  def public_permissions
    Authorization.permissions(self.public_mask)
  end

  def user_permissions=(perms)
    self.user_mask = Authorization.to_mask(perms)
  end
  
  def group_permissions=(perms)
    self.group_mask = Authorization.to_mask(perms)
  end
  
  def public_permissions=(perms)
    self.public_mask = Authorization.to_mask(perms)
  end

end
