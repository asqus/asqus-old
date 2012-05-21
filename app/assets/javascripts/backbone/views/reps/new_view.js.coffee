AsqUs.Views.Reps ||= {}

class AsqUs.Views.Reps.NewView extends Backbone.View
  template: JST["backbone/templates/reps/new"]

  events:
    "submit #new-rep": "save"

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
      success: (rep) =>
        @model = rep
        window.location.hash = "/#{@model.id}"

      error: (rep, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
