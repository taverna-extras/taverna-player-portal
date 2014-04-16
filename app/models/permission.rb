class Permission < ActiveRecord::Base

  belongs_to :policy
  belongs_to :subject, :polymorphic => true

  validates :policy, :presence => true
  validates :subject, :presence => true

  def permissions
    Authorization.to_permissions(self.mask)
  end

  def permissions=(perms)
    self.mask = Authorization.to_mask(perms)
  end

end
