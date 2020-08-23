class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]

  def index
    @projects = Project.all
  end

  def show
    @tickets = @project.tickets
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Your project was created successfully"
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      flash[:notice] = "This project was updated successfully."
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = "The project was deleted successfully."
    else
      flash[:error] = "The project was not able to be deleted. Please try again."
    end
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
