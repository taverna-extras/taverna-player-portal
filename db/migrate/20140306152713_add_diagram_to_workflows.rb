class AddDiagramToWorkflows < ActiveRecord::Migration
  def self.up
    add_attachment :workflows, :diagram
  end

  def self.down
    remove_attachment :workflows, :diagram
  end
end
