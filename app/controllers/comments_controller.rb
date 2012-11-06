class CommentsController < ApplicationController

  def create
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.find(params[:issue_id])
    @comment = @issue.comments.create!(params[:comment].merge(user: current_user))
  end
  
end
