class Api::V1::IssuesController < Api::V1::ApiController

  def index
    @project = current_user.projects.find(params[:project_id])
    @issues = @project.issues
  end

  def show
    @project = current_user.projects.find(params[:id])
    @issue = @project.issues.find(params[:id])
  end

end
