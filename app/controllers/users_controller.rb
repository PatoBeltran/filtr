class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter -> { is_current_user params[:id] }

  def show
    @user = User.find(params[:id])
  end

  def home
    @user = User.find(params[:id])
  end
end
