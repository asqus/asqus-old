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
    ".*"       : "index"

  index: ->
    console.log("cheers")
    @view = new AsqUs.Views.Home.DemoView(polls: @polls, state: @state, count: 0)
    console.log("cheers2")
    $("#home").html(@view.render().el)
    console.log("cheers3")
    
     
