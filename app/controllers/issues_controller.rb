class IssuesController < ApplicationController
  layout false

  def new
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.new
  end

  def show
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.find(params[:id])
    @new_issue = @project.issues.new
    @comment = Comment.new(issue: @issue)
    render 'projects/show', layout: 'application' unless request.xhr?
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.new(issue_params.merge(:user => current_user))
    if @issue.create_github_issue(current_user)
      flash[:notice] = "Issue created!"
      redirect_to @project
    else
      flash[:error] = "This issue could not be created"
      render :new
    end
  end

  def edit
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.find(params[:id])
    @issue.attributes = issue_params
    if @issue.update_github_issue(current_user)
      respond_to do |format|
        format.html do
          flash[:notice] = "Issue updated!"
          redirect_to @project
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = "This issue could not be updated"
          render :edit
        end
        format.js
      end
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :body, :state, :priority_position, :assignee_id, :label_ids)
  end

end
