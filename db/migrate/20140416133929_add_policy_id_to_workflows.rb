class AddPolicyIdToWorkflows < ActiveRecord::Migration
  def change
    add_column :workflows, :policy_id, :integer
    add_index :workflows, :policy_id
  end
end
