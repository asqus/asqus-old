AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.AnswerView extends Backbone.View

  className: "answer_view"

  initialize: (options) ->
    @num_polls_completed = 0

  template: JST["backbone/templates/home/map_view"]
  answerTemplate: JST["backbone/templates/home/answer_view"]

#  events: ->

  render: ->
    $(@el).html(@answerTemplate)
    return this
  

