class FoldersController < ApplicationController

  def index
    @folders = Folder.where(:user_id => current_user).includes(:entries => :resource)
  end

  def update
    @folder = Folder.find(params[:id])
    @folder.entries << FolderEntry.find(params[:entry_id])

    render(:nothing => true, :status => 200)
  end

end
