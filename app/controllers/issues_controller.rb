class IssuesController < ApplicationController

  def new
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.new
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.new(issue_params.merge(:user => current_user))
    if @issue.save
      @issue.update_github(current_user)
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
    @issue.update_attributes(issue_params)
    if @issue.save
      @issue.update_github(current_user)
      flash[:notice] = "Issue updated!"
      respond_to do |format|
        format.html { redirect_to @project }
        format.js
      end
    else
      flash[:error] = "This issue could not be updated"
      respond_to do |format|
        format.html { render :edit }
        format.js
      end
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :body)
  end

end
