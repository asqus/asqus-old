AsqUs.Views.Reps ||= {}

class AsqUs.Views.Reps.RepView extends Backbone.View
  template: JST["backbone/templates/reps/rep"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
