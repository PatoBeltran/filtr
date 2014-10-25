class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def classifier
    @classifier ||= Ankusa::NaiveBayesClassifier.new STORAGE
  end
end
