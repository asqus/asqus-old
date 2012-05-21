AsqUs.Views.Polls ||= {}

class AsqUs.Views.Polls.IndexView extends Backbone.View
  template: JST["backbone/templates/polls/index"]

  initialize: () ->
    @options.polls.bind('reset', @addAll)

  addAll: () =>
    @options.polls.each(@addOne)

  addOne: (poll) =>
    view = new AsqUs.Views.Polls.PollView({model : poll})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(polls: @options.polls.toJSON() ))
    @addAll()

    return this
