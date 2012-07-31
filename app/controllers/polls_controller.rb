class PollsController < ApplicationController

  respond_to :html, :xml, :json


  def vote
  # API requires
  #   :id, :option
  # responds with
  #   [{"option": "Yes", "count": 127}, {"option": "No", "count": 75}]
  # On error:
  #   {"errors": ["error1", "error2"]}
  
    @poll = Poll.where(:id => params[:id] || params[:poll_id]).first
    option_index = params[:option]
    response = Hash.new
    
    if @poll.nil?
      (response['errors'] ||= []) << 'That poll was not found.'
      return respond_with response
    end

    if cookies["voted_on_poll_#{@poll.id}"] === 'true' && false
      (response['errors'] ||= []) << 'You have already voted on this poll.'
      return respond_with response
    end
    
    if option_index.blank? or !option_index.is_numeric?
      (response['errors'] ||= []) << 'A vote option must be specified.'
      return respond_with response
    end
    
    voter_id = (current_user.nil?) ? nil : current_user.id
    vote = @poll.vote_for(option_index.to_i, voter_id)
    if vote.valid?
      @response = @poll.totals
      cookies["voted_on_poll_#{@poll.id}"] = { :value => "true" }
    else
      @response = { :errors => vote.errors.messages.values.collect{|e| e.first} }
    end
    
    respond_to do |format|
      format.html { redirect_to @poll }
      format.json { render :json => @response }
      format.xml { render :xml => @response }
    end
  end
  
  
  def for_user
  # API requires
  #   :user_id
  # responds with
  #   [ [1287903600, 79], [1287990000, 25], [1288076400, 61] ]
  # On error:
  #   {"errors": ["error1", "error2"]}
  #
    response = Hash.new
    begin
      @polls = Poll.received_by_user(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      (response['errors'] ||= []) << 'That user does not exist'
      return respond_with response
    end

    respond_to do |format|
      format.html { redirect_to @polls }
      format.json { render :json => @polls }
      format.xml { render :xml => @polls }
    end
  end


  def totals
  # API requires
  #   :poll_id
  # responds with
  #  [{"count":10,"option":"Yes"},{"count":12,"option":"No"}]
  # On error:
  #   {"errors": ["error1", "error2"]}
  #
    @poll = Poll.where(:id => params[:id] || params[:poll_id]).first
    response = Hash.new

    if @poll.nil?
      (response['errors'] ||= []) << 'That poll was not found.'
      return respond_with response
    end

    respond_with @poll.totals
  end


  def votes_per_day
  # API requires
  #   :id
  # responds with
  #   [ [1287903600, 79], [1287990000, 25], [1288076400, 61] ]
  # On error:
  #   {"errors": ["error1", "error2"]}
  #
    @poll = Poll.where(:id => params[:id] || params[:poll_id]).first
    response = Hash.new
    
    if @poll.nil?
      (response['errors'] ||= []) << 'That poll was not found.'
      return respond_with response
    end
    
    respond_to do |format|
      format.html { redirect_to @poll }
      format.json { render :json => @poll.votes_per_day_as_string }
      format.xml { render :xml => @poll.votes_per_day }
    end
  end
  
  
  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all_with_details

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @polls }
      format.xml { render :xml => @polls }
    end
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    @poll = Poll.find_with_details(params[:id] || params[:poll_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @poll }
      format.xml { render :xml => @poll }
    end
  end

  # GET /polls/new
  # GET /polls/new.json
  def new
    @poll = Poll.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @poll }
      format.xml { render :xml => @poll }
    end
  end

  # GET /polls/1/edit
  def edit
    @poll = Poll.find(params[:id])
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(params[:poll])

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, :notice => 'Poll was successfully created.' }
        format.json { render :json => @poll, :status => :created, :location => @poll }
      else
        format.html { render :action => "new" }
        format.json { render :json => @poll.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /polls/1
  # PUT /polls/1.json
  def update
    @poll = Poll.find(params[:id])

    respond_to do |format|
      if @poll.update_attributes(params[:poll])
        format.html { redirect_to @poll, :notice => 'Poll was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @poll.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy

    respond_to do |format|
      format.html { redirect_to polls_url }
      format.json { head :ok }
    end
  end
end
