class ProjectsController < ApplicationController
  
  
  def index
    @projects = Project.all
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def new
    @project = Project.new
    
  end
  
  def create
    @project = Project.new(project_params)
    @project.user = User.first
    if @project.save
      flash[:success] = "Project was created successfully!"
      redirect_to project_path(@project)
    else
      render 'new'
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:success] = "Project was updated successfully!"
      redirect_to project_path(@project)
    else
      render 'edit'
    end
  end
  
  def destroy
    Project.find( params[:id]).destroy
    flash[:success] = "Project deleted successfully"
    redirect_to projects_path
  end



  private
  
    def project_params
      params.require(:project).permit(:project_name, :control_number)
    end
  
end