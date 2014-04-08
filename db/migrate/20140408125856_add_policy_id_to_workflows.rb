class AddPolicyIdToWorkflows < ActiveRecord::Migration
  def change
    change_table :workflows do |t|
      t.references :policy
    end
  end
end
