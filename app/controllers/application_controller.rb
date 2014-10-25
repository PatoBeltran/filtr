class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def classifier
    @classifier ||= Ankusa::NaiveBayesClassifier.new STORAGE
  end

  def is_current_user(id)
    unless current_user.id.to_s == id
      redirect_to :root, notice: "You don't have the permission to enter."
    end
  end
end
