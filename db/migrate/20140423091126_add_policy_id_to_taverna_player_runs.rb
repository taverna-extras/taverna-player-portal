class AddPolicyIdToTavernaPlayerRuns < ActiveRecord::Migration
  def change
    add_column :taverna_player_runs, :policy_id, :integer
    add_index :taverna_player_runs, :policy_id
  end
end
