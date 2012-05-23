class AsqUs.Routers.HomeRouter extends Backbone.Router
  initialize: (options) ->
    @polls = new AsqUs.Collections.PollsCollection()
    @polls.reset options.polls

  routes:
    "new"      : "newHome"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  index: ->
    @view = new AsqUs.Views.Home.MapView(polls: @polls)
    $("#home").html(@view.render().el)

