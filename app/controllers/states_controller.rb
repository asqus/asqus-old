class StatesController < ApplicationController

  respond_to :json, :xml


  # GET /states.json
  def index
    @states = State.all
    respond_with @states
  end


  # GET /states/1.json
  def show
    state_id = params[:id] || params[:state_id]
    return render :nothing => true unless state_id
    @state = State.find(state_id)
    respond_with @state
  end


  # GET /states/by_abbreviation.json?abbreviation=[abbreviation]
  def by_abbreviation
    abbr = params[:abbreviation]
    return render :nothing => true unless abbr
    @state = State.where(:abbreviation => abbr.upcase).first
    respond_with @state
  end


end
