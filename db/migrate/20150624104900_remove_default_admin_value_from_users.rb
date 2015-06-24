class RemoveDefaultAdminValueFromUsers < ActiveRecord::Migration
  def up
    change_column_default(:users, :admin, nil)
  end

  def down
    change_column_default(:users, :admin, false)
  end
end
