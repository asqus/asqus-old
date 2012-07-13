class AsqUs.Routers.HomeRouter extends Backbone.Router
  initialize: (options) ->
    @polls = new AsqUs.Collections.PollsCollection()
    @polls.reset options.polls

  routes:
    ":id/answer" : "answer"
    ":id/prompt" : "prompt"
    "index"    : "index"
    ".*"       : "index"

  index: ->
    @view = new AsqUs.Views.Home.DemoView(polls: @polls)
    $("#answer").html(@view.render().el)
    
     
