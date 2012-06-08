class AsqUs.Routers.HomeRouter extends Backbone.Router
  initialize: (options) ->
    @polls = new AsqUs.Collections.PollsCollection()
    @polls.reset options.polls
    @state = options.location.state
    @city = options.location.city
    @user_auth = options.user_auth
    console.log(options)
    console.log("chyea")

  routes:
    "nextt"    : "nexttHome"
    "new"      : "newHome"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"       : "index"

  index: ->
    @view = new AsqUs.Views.Home.MapView(polls: @polls, state: @state, count: 0)
    $("#home").html(@view.render().el)
    
    show_alert = false
    
    if(show_alert && !@user_auth && !Cookie.get('browser_location_city'))
      @view = new AsqUs.Views.Home.AlertView(city: @city, user_auth: @user_auth)
      $("#message").html(@view.render().el)
    @user_auth = true
    
  newHome: ->
    console.log("Button new!")
    @view = new AsqUs.Views.Home.MapView(polls: @polls, state: @state)
    $("#home").html(@view.render().el)

  nexttHome: ->
    console.log("Button nextt!")
    @view = new AsqUs.Views.Home.MapView(polls: @polls, state: @state, count: 3)
    $("#home").html(@view.render().el)
