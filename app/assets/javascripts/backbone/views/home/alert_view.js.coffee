AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.AlertView extends Backbone.View

  template: JST["backbone/templates/home/alert_view"]

  initialize: (options) ->
    @city = options.city
    @user_aught = options.user_auth

  render: =>
    $(@el).html(@template(city: @city, user_auth: @user_auth))

    return this
