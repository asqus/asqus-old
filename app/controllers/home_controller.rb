class HomeController < ApplicationController

  def index
    @polls = Poll.all_with_map_information
    @state_name = 'michigan'
  end
  
end
