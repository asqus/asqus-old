class AsqUs.Routers.HomeRouter extends Backbone.Router
  initialize: (options) ->
    @polls = new AsqUs.Collections.PollsCollection()
    @polls.reset options.polls

  routes:
    ":id/answer" : "answer"
    ":id/prompt" : "prompt"
    "index"    : "index"
    ".*"       : "index"
    "intro"    : "index"

  index: ->
    @ask_view = new AsqUs.Views.Home.AskView()
	  $("#ask").html(@ask_view.render().el)
    @answer_view = new AsqUs.Views.Home.DemoView(polls: @polls)
    $("#answer").html(@answer_view.render().el)
    
     
