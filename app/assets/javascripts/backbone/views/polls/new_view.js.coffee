AsqUs.Views.Polls ||= {}

class AsqUs.Views.Polls.NewView extends Backbone.View
  template: JST["backbone/templates/polls/new"]

  events:
    "submit #new-poll": "save"

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
      success: (poll) =>
        @model = poll
        #window.location.hash = "/#{@model.id}"
        #change this later!
        window.router.navigate("ask", (trigger: true))
        $("#create_poll_button").show() 
        window.router.navigate("ask", (trigger: true))

      error: (poll, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
