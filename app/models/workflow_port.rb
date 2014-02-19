class WorkflowPort < ActiveRecord::Base

  self.abstract_class = true

  belongs_to :workflow
  validates :name, :presence => true

end
