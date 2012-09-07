class ProjectsController < ApplicationController

  def index
    @projects = current_user.projects
  end

  def create
    owner = params[:full_name].split("/")[0]
    name = params[:full_name].split("/")[1]
    org = params[:org]
    @project = current_user.owned_projects.where(owner: owner, name: name).first || current_user.owned_projects.new(owner: owner, name: name, org: org)
    if @project.persisted? || @project.save
      @project.import_labels
      @project.import_team
      @project.import_issues
      redirect_to @project
    else
      flash[:error] = "There was an error importing that project to Gitomic"
      redirect_to root_path
    end
  end

  def show
    @project = current_user.projects.find(params[:id])
  end

  def import
  end


end
