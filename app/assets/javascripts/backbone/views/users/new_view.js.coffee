AsqUs.Views.Users ||= {}

class AsqUs.Views.Users.NewView extends Backbone.View
  template: JST["backbone/templates/users/new"]

  events:
    "submit #new-user": "save"

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
      success: (user) =>
        @model = user
        window.location.hash = "/#{@model.id}"

      error: (user, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
