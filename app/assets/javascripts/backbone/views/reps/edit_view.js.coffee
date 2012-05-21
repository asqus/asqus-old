AsqUs.Views.Reps ||= {}

class AsqUs.Views.Reps.EditView extends Backbone.View
  template : JST["backbone/templates/reps/edit"]

  events :
    "submit #edit-rep" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (rep) =>
        @model = rep
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
