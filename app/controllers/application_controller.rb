class ApplicationController < ActionController::Base

  protect_from_forgery
  after_filter :update_last_location

  
  
  # If the currently signed in user is not a rep, redirect him to last_clean_url with an error.
  def assert_rep!
    authenticate_user!
    if current_user.rep
      return true
    else
      redirect_to session[:last_clean_url]
    end
  end
  
  
  protected
  
  def update_last_location
    session[:last_clean_url] = request.url
  end
  
end
