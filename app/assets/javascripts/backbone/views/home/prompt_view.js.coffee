AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.PromptView extends Backbone.View

  template: JST["backbone/templates/home/prompt_view"]

  initialize: ->
    @count = 0

  events:
    "click .pollAnswer" : "nextPoll"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (user) =>
        @model = user
        window.location.hash = "/#{@model.id}"
    )


  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

  nextPoll: ->
    @render()


