class WikisController < ApplicationController

  include Pundit

  def index
   
      @wikis = policy_scope(Wiki)
    
  end

  def private 
    @wikis = Wiki.visible_to_private
  end

  def show
    @wiki = Wiki.find(params[:id])

    
  end


  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.user = current_user
    @wiki.private = params[:wiki][:private]

    
    if @wiki.save
      flash[:notice] = "Wiki was saved"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your wiki"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    

    if @wiki.save
      flash[:notice] = "Wiki was updated"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating your wiki"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted"
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting your wiki!"
      render :show
    end
  end
end
