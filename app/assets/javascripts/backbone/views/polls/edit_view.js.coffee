AsqUs.Views.Polls ||= {}

class AsqUs.Views.Polls.EditView extends Backbone.View
  template : JST["backbone/templates/polls/edit"]

  events :
    "submit #edit-poll" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (poll) =>
        @model = poll
        console.log("new poll update")
        #window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
