class HomeController < ApplicationController

  def index
    @polls = Poll.all
  end
  
end
