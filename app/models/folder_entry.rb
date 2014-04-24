class FolderEntry < ActiveRecord::Base

  belongs_to :folder
  belongs_to :resource, :polymorphic => true

end
