class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]

  def index
    @tags = Tag.sort_tags
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      flash[:notice] = "Your tag was created successfully"
      redirect_to tags_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      flash[:notice] = "This tag was updated successfully."
      redirect_to tags_path
    else
      render :edit
    end
  end

  def destroy
    if @tag.destroy
      flash[:notice] = "The tag was deleted successfully."
    else
      flash[:error] = "The tag was not able to be deleted. Please try again."
    end
    redirect_to tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
