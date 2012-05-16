AsqUs.Views.Groups ||= {}

class AsqUs.Views.Groups.EditView extends Backbone.View
  template : JST["backbone/templates/groups/edit"]

  events :
    "submit #edit-group" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (group) =>
        @model = group
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
