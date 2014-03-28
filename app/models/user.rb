class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :presence => true

  before_save :first_user_admin

  def can?(action, object)
    object.user_id == self.id || self.admin?
  end

  def admin?
    admin
  end

  private

  def first_user_admin
    self.admin = true if User.count == 0
  end
end
