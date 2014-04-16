class Policy < ActiveRecord::Base

  def permits?(user, action)
    mask = Authorization.to_mask([Authorization.privilege_for_action(action)])

    return true if (user && user.admin?)

    return true if (public_mask & mask == mask)

    perms = self.permissions.select do |p|
      user && (p.for == user || user.groups.include?(p.for))
    end

    true if perms.any? { |p| p.mask & mask == mask }
  end

  def public_permissions
    Authorization.permissions(self.public_mask)
  end

  def public_permissions=(perms)
    self.public_mask = Authorization.to_mask(perms)
  end

end
