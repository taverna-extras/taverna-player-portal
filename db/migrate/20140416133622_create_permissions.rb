class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :policy
      t.references :subject, :polymorphic => true
      t.integer :mask
    end
  end
end
