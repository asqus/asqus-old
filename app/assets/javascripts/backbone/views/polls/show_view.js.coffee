AsqUs.Views.Polls ||= {}

class AsqUs.Views.Polls.ShowView extends Backbone.View
  template: JST["backbone/templates/polls/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
