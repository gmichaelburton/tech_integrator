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
  



  private
  
    def project_params
      params.require(:project).permit(:project_name, :control_number)
    end
  
end