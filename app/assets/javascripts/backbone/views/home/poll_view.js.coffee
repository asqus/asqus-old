AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.PollView extends Backbone.View

  template: JST["backbone/templates/home/poll_view"]

  initialize: ->
    @count = 0

  events:
    "click .pollAnswer" : "nextPoll"

  render: ->
    poll = @options.polls.at(@count)
    $(@el).html(@template(poll.toJSON() ))
    return this

  nextPoll: ->
    @count++
    if(! @options.polls.at(@count))
      @count = 0
    @render()


