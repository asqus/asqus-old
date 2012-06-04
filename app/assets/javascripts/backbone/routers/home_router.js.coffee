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
    @view = new AsqUs.Views.Home.MapView(polls: @polls, state: @state)
    $("#home").html(@view.render().el)
    if(!@user_auth && !Cookie.get('browser_location_city'))
      @view = new AsqUs.Views.Home.AlertView(city: @city, user_auth: @user_auth)
      $("#message").html(@view.render().el)
    @user_auth = true
    
  

