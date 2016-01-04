class CollaboratorsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(user_id:@user.id, wiki_id: @wiki.id)
    
    authorize @collaborator
    
    if @collaborator.save
      flash[:notice] = "Collaborator saved"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your collaborator"
      redirect_to @wiki
    end 
  end

  def destroy
    @user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find_by(user_id: @user.id, wiki_id: @wiki.id)
    
    authorize @collaborator
    
    if @collaborator.destroy
      flash[:notice] = "Collaborator deleted"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error deleting your collaborator"
      render :show
     end 
  end
end
