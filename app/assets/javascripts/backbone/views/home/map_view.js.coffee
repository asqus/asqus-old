AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.MapView extends Backbone.View

  initialize: (options) ->
    @state = options.state

  template: JST["backbone/templates/home/map_view"]
  
  #question_bubble_template: JST['backbone/templates/polls/_question_bubble']

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    #@model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template({state_graphic_path: "/assets/#{@state}_outline.gif"}))
    @populateMap()
    return this
  
  
  populateMap: ->
    mapElement = @$el
    stateGraphic = $('#state .state_graphic')[0]
    mapWidth = stateGraphic.width
    mapHeight = stateGraphic.height
    
    @options.polls.each (poll) ->
      question_bubble = $('<div class="speech_bubble"></div>')
      bubble_direction = if (poll.attributes.poll_type == 'user') then 'from_right' else 'from_left'
      question_bubble.addClass(bubble_direction)
      question_bubble.css
        left: "#{poll.attributes.map_x_coord / 100 * mapWidth}px"
        top: "#{poll.attributes.map_y_coord / 100 * mapHeight}px"
      mapElement.append(question_bubble)


