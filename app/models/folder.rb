class Folder < ActiveRecord::Base

  belongs_to :user
  has_many :folder_entries, :dependent => :destroy

  def items
    self.folder_entries.map { |e| e.resource }
  end

end
