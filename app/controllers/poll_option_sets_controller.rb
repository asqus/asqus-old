class PollOptionSetsController < ApplicationController
  # GET /poll_option_sets
  # GET /poll_option_sets.json
  def index
    @poll_option_sets = PollOptionSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @poll_option_sets }
    end
  end

  # GET /poll_option_sets/1
  # GET /poll_option_sets/1.json
  def show
    @poll_option_set = PollOptionSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @poll_option_set }
    end
  end

  # GET /poll_option_sets/new
  # GET /poll_option_sets/new.json
  def new
    @poll_option_set = PollOptionSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @poll_option_set }
    end
  end

  # GET /poll_option_sets/1/edit
  def edit
    @poll_option_set = PollOptionSet.find(params[:id])
  end

  # POST /poll_option_sets
  # POST /poll_option_sets.json
  def create
    @poll_option_set = PollOptionSet.new(params[:poll_option_set])

    respond_to do |format|
      if @poll_option_set.save
        format.html { redirect_to @poll_option_set, :notice => 'Poll option set was successfully created.' }
        format.json { render :json => @poll_option_set, :status => :created, :location => @poll_option_set }
      else
        format.html { render :action => "new" }
        format.json { render :json => @poll_option_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /poll_option_sets/1
  # PUT /poll_option_sets/1.json
  def update
    @poll_option_set = PollOptionSet.find(params[:id])

    respond_to do |format|
      if @poll_option_set.update_attributes(params[:poll_option_set])
        format.html { redirect_to @poll_option_set, :notice => 'Poll option set was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @poll_option_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /poll_option_sets/1
  # DELETE /poll_option_sets/1.json
  def destroy
    @poll_option_set = PollOptionSet.find(params[:id])
    @poll_option_set.destroy

    respond_to do |format|
      format.html { redirect_to poll_option_sets_url }
      format.json { head :ok }
    end
  end
end
