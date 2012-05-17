AsqUs.Views.Groups ||= {}

class AsqUs.Views.Groups.NewView extends Backbone.View
  template: JST["backbone/templates/groups/new"]

  events:
    "submit #new-group": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (group) =>
        @model = group
        window.location.hash = "/#{@model.id}"

      error: (group, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
