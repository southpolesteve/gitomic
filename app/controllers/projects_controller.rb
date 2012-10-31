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
      current_user.projects << @project
      redirect_to @project
    else
      flash[:error] = "There was an error importing that project to Gitomic"
      redirect_to root_path
    end
  end

  def show
    @project = current_user.projects.find(params[:id])
  end

  def settings
  end

end
