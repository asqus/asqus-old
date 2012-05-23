AsqUs.Views.Reps ||= {}

class AsqUs.Views.Reps.ShowView extends Backbone.View
  template: JST["backbone/templates/reps/show"]

  render: ->
    console.log 'Show view:'
    #@model.fetch()
    window.asdf = this.options
    console.log @model.toJSON()
    $(@el).html(@template(@model.toJSON() ))
    return this
