AsqUs.Views.Groups ||= {}

class AsqUs.Views.Groups.GroupView extends Backbone.View
  template: JST["backbone/templates/groups/group"]

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
