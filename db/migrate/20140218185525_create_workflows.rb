class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.string :title
      t.text :description
      t.references :user
      t.attachment :document

      t.timestamps
    end
  end
end

