class ProjectsController < ApplicationController

  def index
    @projects = current_user.projects
  end

  def create
    owner = params[:full_name].split("/")[0]
    name = params[:full_name].split("/")[1]
    org = params[:org]
    @project = current_user.owned_projects.where(owner: owner, name: name).first_or_create
    if @project
      @project.import_github_async
      redirect_to @project
    else
      flash[:error] = "There was an error importing that project to Gitomic"
      redirect_to root_path
    end
  end

  def show
    @project = current_user.projects.find(params[:id])
    @new_issue = @project.issues.new(user: current_user)
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    flash[:success] = "Project has been destroyed. All data related to this project has been removed from Gitomic"
    redirect_to projects_path
  end

  def settings
    @project = current_user.projects.find(params[:id])
  end

end
