class IssuesController < ApplicationController

  def new
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.new
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.new(params[:issue].merge(:user => current_user))
    if @issue.save
      flash[:notice] = "Issue created!"
      @issue.create_github_issue(current_user)
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
    @issue.update_attributes(params[:issue])
    if @issue.save
      flash[:notice] = "Issue updated!"
      @issue.update_github_issue(current_user)
      redirect_to @project
    else
      flash[:error] = "This issue could not be updated"
      render :edit
    end
  end

end
