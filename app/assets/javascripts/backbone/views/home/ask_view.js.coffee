AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.AskView extends Backbone.View

  className: "ask_view"

  initialize: (options) ->
    @num_polls_completed = 0

  template: JST["backbone/templates/home/map_view"]
  askTemplate: JST["backbone/templates/home/ask_view"]

  events: ->
    "submit form.askQuestion" : "showQuestion"
    #"click .submitQuestion" : "showQuestion"
  
  showQuestion: ->
    console.log("check it")
    formData = $('form.askQuestion')
    @title = $('input.askTitle').val()
    @prompt = $('textarea.askPrompt').val()
    console.log(formData)
    #@resultView = new AsqUs.Views.Polls.ResultView(model: poll)
    $(@el).html(@title + @prompt)
    return false

  render: ->
    $(@el).html(@askTemplate)
    return this
  

