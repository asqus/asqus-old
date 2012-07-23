AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.AskView extends Backbone.View

  className: "askExample"

  initialize: (options) ->
    @num_polls_completed = 0

  template: JST["backbone/templates/home/map_view"]
  askTemplate: JST["backbone/templates/home/ask_view"]

  events: ->
    "click .submitQuestion" : "showQuestion"
  
  showQuestion: ->
    @resultView = new AsqUs.Views.Polls.ResultView(model: poll)
    $(@el).html(@resultView)

  render: ->
    $(@el).html(@askTemplate())
    return this
  

