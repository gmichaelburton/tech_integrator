class ProjectsController < ApplicationController
  
  before_action :set_project, only: [:show, :edit, :update]
  
  
  def index
    @projects = Project.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    
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
    
  end
  
  def update
   
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
  
    def set_project
      @project = Project.find(params[:id])
    end
  
    def project_params
      params.require(:project).permit(:project_name, :control_number)
    end
  
end