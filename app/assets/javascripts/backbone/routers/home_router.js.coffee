class AsqUs.Routers.HomeRouter extends Backbone.Router
  initialize: (options) ->
    @polls = new AsqUs.Collections.PollsCollection()
    @polls.reset options.polls
    window.test = @polls
    @state = options.location.state
    @city = options.location.city
    @user_auth = options.user_auth
    console.log(options)
    @firstPage = true

  routes:
    ":id/answer" : "answer"
    ":id/prompt" : "prompt"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"       : "index"

  index: ->
    @view = new AsqUs.Views.Home.MapView(polls: @polls, state: @state, count: 0)
    $("#home").html(@view.render().el)
    @view.updatePips(1)
    @view.highlightBubble(@polls.at(1).attributes.id)
    
    show_alert = false
    
    if(show_alert && !@user_auth && !Cookie.get('browser_location_city'))
      @view = new AsqUs.Views.Home.AlertView(city: @city, user_auth: @user_auth)
      $("#message").html(@view.render().el)
    @user_auth = true
    
  prompt: (id) ->
    console.log("Prompt!")
    poll = @polls.get(id)
    @view = new AsqUs.Views.Home.PromptView(model: poll)
    $("#home").html(@view.render().el)
    #@slideView(@view)

  answer: (id) ->
    console.log("Answer!")
    poll = @polls.get(id)
    @view = new AsqUs.Views.Home.PollView(model: poll)
    $("#home").html(@view.render().el)
    #@slideView(@view)

  slideView: (page) ->
    console.log("Slide View!")
    $(page.el).attr('data-role', 'page')
    page.render()
    $("body").append($(page.el))
    transition = $.mobile.defaultPageTransition
    if (@firstPage)
      transition = 'none'
      @firstPage = false
    console.log("Slide 5!")
    $.mobile.changePage($(page.el), {changeHash:false, transition: transition})
    console.log("Slide 6!")
     
