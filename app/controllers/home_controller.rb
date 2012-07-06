class HomeController < ApplicationController


  def index
  end


  def faq
  end
  
  
  def map
    @polls = Poll.all_with_details
    @state_name = cookies[:browser_location_state] || 'Michigan'
    @city_name = cookies[:browser_location_city] || 'Ann Arbor'
    @user_auth = user_signed_in?
  end

  
end
