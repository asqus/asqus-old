class AsqUs.Routers.PollsRouter extends Backbone.Router
  initialize: (options) ->
    @polls = new AsqUs.Collections.PollsCollection()
    @polls.reset options.polls

  routes:
    "new"      : "newPoll"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newPoll: ->
    @view = new AsqUs.Views.Polls.NewView(collection: @polls)
    $("#polls").html(@view.render().el)
    @view = new AsqUs.Views.Polls.IndexView(polls: @polls)
    $("#polls_list").html(@view.render().el)

  index: ->
    @view = new AsqUs.Views.Polls.IndexView(polls: @polls)
    $("#polls_list").html(@view.render().el)

  show: (id) ->
    poll = @polls.get(id)
    $("#polls").html("")
    @view = new AsqUs.Views.Polls.IndexView(polls: @polls)
    $("#polls_list").html(@view.render().el)

  edit: (id) ->
    poll = @polls.get(id)

    @view = new AsqUs.Views.Polls.EditView(model: poll)
    $("#polls").html(@view.render().el)
    @view = new AsqUs.Views.Polls.IndexView(polls: @polls)
    $("#polls_list").html(@view.render().el)
