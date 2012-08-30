class IssuesController < ApplicationController

  def new
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.new
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.new(issue_params.merge(:user => current_user))
    @issue = @issue.update_github(current_user) if @issue.valid?
    if @issue.save
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
    @issue.update_github(current_user) if @issue.valid?
    if @issue.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Issue updated!"
          redirect_to @project
        end
        format.js { render :js => "console.log('success');" }
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = "This issue could not be updated"
          render :edit
        end
        format.js { render :js => "console.log('error');" }
      end
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :body, :state, :icebox_priority_position, :backlog_priority_position)
  end

end
