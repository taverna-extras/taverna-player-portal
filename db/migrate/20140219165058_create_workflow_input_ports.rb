class CreateWorkflowInputPorts < ActiveRecord::Migration
  def change
    create_table :workflow_input_ports do |t|
      t.references :workflow
      t.string :name
      t.text :description
      t.text :example_value
    end
  end
end
