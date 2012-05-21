AsqUs.Views.Reps ||= {}

class AsqUs.Views.Reps.IndexView extends Backbone.View
  template: JST["backbone/templates/reps/index"]

  initialize: () ->
    @options.reps.bind('reset', @addAll)

  addAll: () =>
    @options.reps.each(@addOne)

  addOne: (rep) =>
    view = new AsqUs.Views.Reps.RepView({model : rep})
    @$("tbody").append(view.render().el)

  render: =>
    console.log(@options)
    $(@el).html(@template(rep: @options.rep.toJSON() ))
    @addAll()

    return this
