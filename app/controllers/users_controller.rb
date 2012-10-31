class UsersController < ApplicationController
  def invite
    @user = User.find(params[:id])
    @user.invite
  end
end
