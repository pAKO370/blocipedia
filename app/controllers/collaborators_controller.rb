class CollaboratorsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(user_id:@user.id, wiki_id: @wiki.id)
    authorize @collaborator
    if @collaborator.save
      flash[:notice] = "Collaborator saved"
      redirect_to_wikis_path
    else
      flash.now[:alert] = "There was an error saving your collaborator"
      render :show
     end 
  end

  def delete
  end
end
