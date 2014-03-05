class WorkflowPort < ActiveRecord::Base

  self.abstract_class = true

  belongs_to :workflow
  validates :name, :presence => true

  def example
    self.example_value
  end

end
