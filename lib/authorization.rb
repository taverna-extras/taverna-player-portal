module Authorization

  PRIVILEGES = {
    :none => 0,
    :view => 1,    # read
    :edit => 2,    # write
    :execute => 4  # execute
  }.freeze

  def self.permissions(mask)
    Authorization::PRIVILEGES.select  { |_, index| mask & index != 0 }.keys
  end

  def self.to_mask(permissions)
    permissions = [permissions] if permissions.is_a?(Symbol)
    permissions.inject(0) { |mask, permission| mask + (PRIVILEGES[permission.to_sym] || 0) }
  end

  def self.included(base)
    base.class_eval do
      # Find only things that the given user has the given privilege for
      # Also loads permissions into memory.
      scope :with_permissions, lambda { |user, permissions|
        mask = Authorization.to_mask(permissions)
        joins(:policy).
        where("(policies.user_mask   & ? != 0 AND policies.user_id = ?) OR
               (policies.group_mask  & ? != 0 AND policies.group_id IN (?)) OR
               (policies.public_mask & ? != 0)",
              mask, user,
              mask, user.try(:groups) || [],
              mask)
      }

      belongs_to :policy, :dependent => :destroy

      accepts_nested_attributes_for :policy

      before_validation :ensure_policy
    end
  end

  # Check if the given user has the given privilege.
  # Doesn't need to do additional queries if operating on a #with_privilege scope.
  def can?(user, action)
    self.policy.permits?(user, action)
  end

  def ensure_policy
    self.policy ||= default_policy
  end

  private

  def Authorization.privilege_for_action(action)
    case action.to_sym
      when :new, :create
        :none
      when :view, :show, :index, :download
        :view
      when :edit, :update, :manage, :destroy
        :edit
      else
        :none
    end
  end

  def default_policy
    Policy.new(:user => user, :user_permissions => [:view, :edit, :execute],
               :group_permissions => [:view, :edit, :execute],
               :public_permissions => [:view, :execute])
  end

end
