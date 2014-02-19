class Workflow < ActiveRecord::Base

  belongs_to :user
  has_attached_file :document

  def self.mime_type
    "application/vnd.taverna.t2flow+xml"
  end

end
