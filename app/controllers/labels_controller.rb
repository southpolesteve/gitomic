class LabelsController < ApplicationController

  def new
    @project = current_user.project.find(params[:id])
    @label = @project.labels.new
  end

  def create_list
    @project = current_user.project.find(params[:project_id])
    @label = @project.labels.find(params[:id])
  end

end
