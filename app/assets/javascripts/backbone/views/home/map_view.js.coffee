AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.MapView extends Backbone.View
  template: JST["backbone/templates/home/map_view"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    #@model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template({state_graphic_path: '/assets/michigan_outline.gif'}))
    return this
