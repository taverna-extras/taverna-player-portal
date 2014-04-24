class CreateFolderEntries < ActiveRecord::Migration
  def change
    create_table :folder_entries do |t|
      t.references :folder
      t.references :resource, :polymorphic => true
    end
  end
end
