class AsqUs.Routers.HomeRouter extends Backbone.Router
  initialize: (options) ->
    @polls = new AsqUs.Collections.PollsCollection()
    @polls.reset options.polls
    @state = options.location.state
    @city = options.location.city
    @user_auth = options.user_auth
    console.log(options)

  routes:
    "new"      : "newHome"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  index: ->
    poll = @polls.at(1)

    @view = new AsqUs.Views.Home.MapView(polls: @polls, el: '#map', state: @state)
    $("#home").html(@view.render().el)
    @view = new AsqUs.Views.Home.PollView(polls: @polls)
    $("#poll").html(@view.render().el)
    if(! @user_auth)
      @view = new AsqUs.Views.Home.AlertView(city: @city, user_auth: @user_auth)
      $("#message").html(@view.render().el)
    @user_auth = true
    
  

