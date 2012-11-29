class LabelsController < ApplicationController

  def new
    @project = current_user.projects.find(params[:project_id])
    @label = @project.labels.new
  end

end
