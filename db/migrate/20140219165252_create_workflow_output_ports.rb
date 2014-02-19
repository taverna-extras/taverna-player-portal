class CreateWorkflowOutputPorts < ActiveRecord::Migration
  def change
    create_table :workflow_output_ports do |t|
      t.references :workflow
      t.string :name
      t.text :description
      t.text :example_value
    end
  end
end
