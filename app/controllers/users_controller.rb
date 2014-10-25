class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter -> { is_current_user params[:id] }

  def show
    @user = User.find(params[:id])
  end

  def home
    @user = User.find(params[:id])
    @classifier = classifier
    @posts = params[:page] ? @user.facebook.get_page(params[:page]) : @user.facebook.get_connections("me", "home?fields=id,message,type,picture")
    @results =  @posts.select { |a| (a["type"] == "status" || a["type"] == "link" || a["type"] == "photo") && a["message"] && !ClasifiedPost.find_by(pid: a["id"]) }
  end

  def classify
    @classifier = classifier
    @classifier.train params["type"], params["message"]
    a = ClasifiedPost.new pid: params["pid"]
    a.save!
    redirect_to :back
  end
end
