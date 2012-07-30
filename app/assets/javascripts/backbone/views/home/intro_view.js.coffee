AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.IntroView extends Backbone.View

  className: "intro_view"

  initialize: (options) ->
    @num_polls_completed = 0

  introTemplate: JST["backbone/templates/home/intro_view"]

  events: ->
    "submit form.askQuestion" : "showQuestion"
  
  showQuestion: ->
    console.log("check it")

  render: ->
    $(@el).html(@introTemplate)
    return this
  

