class PagesController < ApplicationController
  def landing
    if user_signed_in?
      redirect_to home_user_path(current_user)
    end
  end
end
