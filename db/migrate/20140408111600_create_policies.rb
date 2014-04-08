class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.references :user
      t.references :group
      t.integer :user_mask, :default => 0
      t.integer :group_mask, :default => 0
      t.integer :public_mask, :default => 0
    end
  end
end
