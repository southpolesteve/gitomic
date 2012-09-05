class ListsController < ApplicationController

  def new
    @project = current_user.projects.find(params[:project_id])
    @list = @project.lists.new
    @labels = @project.labels.without_list
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @list = @project.lists.new(list_params)
    @list.project = @project
    if @list.save
      flash[:notice] = "This worked!"
      redirect_to @project
    else
      @labels = @project.labels.without_list
      flash[:notice] = "This failed!"
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:label, :name)
  end

end