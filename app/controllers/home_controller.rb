class HomeController < ApplicationController

  def index
    @polls = Poll.all_with_map_information
    @state_name = 'michigan'
    @city_name = 'Ann Arbor'
    @user_auth = user_signed_in?
  end
  
end
