class HomeController < ApplicationController
  def index
    if current_user
      redirect_to projects_path and return
    end

    if Rails.env != "production"
      render "landing", :layout => "landing"
    end

  end
end
