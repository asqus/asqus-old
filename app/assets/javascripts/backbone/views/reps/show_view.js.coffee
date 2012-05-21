AsqUs.Views.Reps ||= {}

class AsqUs.Views.Reps.ShowView extends Backbone.View
  template: JST["backbone/templates/reps/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
