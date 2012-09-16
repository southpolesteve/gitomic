class LabelsController < ApplicationController

  def new
    @project = current_user.projects.find(params[:project_id])
    @label = @project.labels.new
  end

  def make_list
    @project = current_user.projects.find(params[:project_id])
    @label = @project.labels.find(params[:id])
    if @label.update_attribute(:list, true)
      flash[:notice] = "List created from label '#{@label.name}'"
    else
      flash[:error] = "List could not be created"
    end
    redirect_to @project
  end

end
