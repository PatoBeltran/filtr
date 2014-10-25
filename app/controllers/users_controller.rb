class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter -> { is_current_user params[:id] }

  def show
    @user = User.find(params[:id])
  end

  def home
    @user = User.find(params[:id])
    @classifier = classifier

    begin
      @posts = params[:page] ? @user.facebook.get_page(params[:page]) : @user.facebook.get_connections("me", "home?fields=id,message,type,picture,from")
      @results =  @posts.select { |a| (a["type"] == "status" || a["type"] == "link" || a["type"] == "photo") && a["message"]}

      @results_clever = @results.select {|a|  newClassify("#{a["message"]}") == "clever"}
      @results_cheesy = @results.select {|a|  newClassify("#{a["message"]}") == "cheesy"}
      @results_cool = @results.select {|a| newClassify("#{a["message"]}") == "cool"}

      @results = @results.select { |a| !ClasifiedPost.find_by(pid: a["id"]) } if current_user.admin?
    rescue
      @error = "You didn't give the app permission to view your news feed :("
    end
  end

  def classify
    @classifier = classifier
    @classifier.train params["type"], params["message"]
    a = ClasifiedPost.new pid: params["pid"]
    a.save!
    redirect_to :back
  end

  private

  def newClassify (msg)
    classifications = @classifier.classifications(msg)
    if (classifications["cool"] >= 0.9)
      classifications["cool"] = classifications["cool"] - 0.9
    end

    classifications.key classifications.values.max
  end

end
