class ProjectsController < ApplicationController

  def index
    @projects = current_user.projects
  end

  def create
    owner = params[:full_name].split("/")[0]
    name = params[:full_name].split("/")[1]
    @project = current_user.projects.where(owner: owner, name: name).first || current_user.projects.new(owner: owner, name: name)
    if @project.persisted? || @project.save
      @project.import_github_issues
      @project.setup_github_labels
      redirect_to @project
    else
      flash[:error] = "There was an error importing that project to MurfHub"
      redirect_to root_path
    end
  end

  def show
    @project = current_user.projects.find(params[:id])
    @issues = @project.issues.order('number ASC')
  end


end
