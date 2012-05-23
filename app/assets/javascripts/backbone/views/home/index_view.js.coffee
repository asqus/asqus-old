AsqUs.Views.Homes ||= {}

class AsqUs.Views.Homes.IndexView extends Backbone.View
  template: JST["backbone/templates/homes/index"]

  initialize: () ->
    @options.homes.bind('reset', @addAll)

  addAll: () =>
    @options.homes.each(@addOne)

  addOne: (home) =>
    view = new AsqUs.Views.Homes.HomeView({model : home})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(homes: @options.homes.toJSON() ))
    @addAll()

    return this
