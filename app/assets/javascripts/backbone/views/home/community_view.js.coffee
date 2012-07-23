AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.CommunityView extends Backbone.View

  className: 'community_view'

  template: JST["backbone/templates/home/community"]
  

  events: ->


  initialize: (options) ->
    

  render: ->
    @$el.html(@template())
    return this

    

