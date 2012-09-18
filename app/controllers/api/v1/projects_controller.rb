class Api::V1::ProjectsController < Api::V1::ApiController

  def index
    @projects = current_user.projects
  end

  def show
    @project = current_user.projects.find(params[:id])
  end

end
