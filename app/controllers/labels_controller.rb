class LabelsController < ApplicationController

  def new
    @project = current_user.project.find(params[:id])
    @label = @project.labels.new
  end

  def create
    
  end

end
