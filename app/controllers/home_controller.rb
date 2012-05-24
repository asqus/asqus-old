class HomeController < ApplicationController

  def index
    @polls = Poll.all_with_map_coords
    @state_name = 'michigan'
  end
  
end
