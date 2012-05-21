class ApplicationController < ActionController::Base

  protect_from_forgery
  after_filter :update_last_location

  
  
  # If the currently signed in user is not a rep, redirect him to last_clean_url with an error.
  def assert_rep!
    authenticate_user!
    if current_user.is_rep?
      return true
    else
      flash[:error] = 'Oops, you must be democratically elected to view that page.'
      redirect_to session[:last_clean_url]
    end
  end
  
  
  protected
  
  def update_last_location
    session[:last_clean_url] = request.url
  end
  
end
