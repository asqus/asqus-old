AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.MapView extends Backbone.View

  className: "map"

  initialize: (options) ->
    @state = options.state
    @count = 0
    $(@el).html(@template({state_graphic_path: "/assets/#{@state}_outline.gif"}))
    poll = @options.polls.at(@count)
    $(@el).append(@pollTemplate(poll.toJSON()))

    #@render()

  template: JST["backbone/templates/home/map_view"]
  pollTemplate: JST["backbone/templates/home/poll_view"]
  
  #question_bubble_template: JST['backbone/templates/polls/_question_bubble']

  events:
    "click .destroy" : "destroy"
    "click .agree" : "doLog"
    "click .pollAnswer" : "nextPoll"
    "click .pollTest" : "nextPoll"
    "hover .speech_bubble" : "hover"
    "click .speech_bubble" : "replacePoll"

  destroy: () ->
    #@model.destroy()
    this.remove()

    return false

  hover:(e) ->
    $(e.currentTarget).toggleClass("hl_temp")

  render: ->
    #$(@el).html(@template({state_graphic_path: "/assets/#{@state}_outline.gif"}))
    #this.el.html(@template({state_graphic_path: "/assets/#{@state}_outline.gif"}))
    @populateMap()
    @populatePoll()
    return this
  
  
  populateMap: ->
    mapElement = @$el
    stateGraphic = $('#state .state_graphic')[0]
    if(!stateGraphic)
      return false
    mapWidth = stateGraphic.width
    mapHeight = stateGraphic.height
    
    @options.polls.each (single_poll) ->
      #console.log(single_poll.toJSON())
      console.log(single_poll)
      question_bubble = $('<div class="speech_bubble '+single_poll.id+'" id="'+single_poll.id+'"></div>')
      bubble_direction = if (single_poll.attributes.creator_info.type == 'user') then 'from_right' else 'from_left'
      question_bubble.addClass(bubble_direction)
      question_bubble.css
        left: "#{single_poll.attributes.map_x_coord / 100 * mapWidth}px"
        top: "#{single_poll.attributes.map_y_coord / 100 * mapHeight}px"
      mapElement.append(question_bubble)
      #$(".speech_bubble." + poll.id).data("hmm", {argbarg: "99999999"})

  populatePoll: ->
    $(".poll-info").remove()
    poll = @options.polls.at(@count)
    #pollElement.html(@pollTemplate(poll.toJSON()))
    newText = ".speech_bubble." + poll.id
    console.log(newText)
    currentBubble = $(newText)
    console.log(currentBubble)
    if(!currentBubble.hasClass("hl"))
      $(".speech_bubble").removeClass("hl")
      #Toggle would be better here!
      currentBubble.addClass("hl")
    $(@el).append(@pollTemplate(poll.toJSON()))

#How to get the id of question bubble, and then switch to that question
  replacePoll:(e) ->
    $(".poll-info").remove()
    console.log('test')
    newID = e.currentTarget.id
    console.log(newID)
    console.log(" blbah" )
    poll = @options.polls.get(newID)
    console.log(poll)
    currentBubble = $(".speech_bubble." + poll.id)
    $(".speech_bubble").removeClass("hl")
    currentBubble.addClass("hl")
    console.log(currentBubble)
    $(@el).append(@pollTemplate(poll.toJSON()))

  nextPoll: ->
    @count++
    console.log(@count)
    if(! @options.polls.at(@count))
      @count = 0
    @populatePoll()

  doLog: ->
    console.log("yes")
    @render()

