class Folder < ActiveRecord::Base

  belongs_to :user
  has_many :entries, :class_name => 'FolderEntry', :dependent => :destroy
  has_many :runs, :through => :entries, :source => :resource, :source_type => 'TavernaPlayer::Run'

  def contents
    self.entries.map { |e| e.resource }
  end

end
