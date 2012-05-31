AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.MapView extends Backbone.View

  className: "map"

  initialize: (options) ->
    @state = options.state
    @count = 0
    $(@el).html(@template({state_graphic_path: "/assets/#{@state}_outline.gif"}))

  template: JST["backbone/templates/home/map_view"]
  pollTemplate: JST["backbone/templates/home/poll_view"]
  
  events:
    "click .destroy" : "destroy"
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
    @populateMap()
    @populatePoll()
    return this
  
  
  populateMap: ->
    mapElement = @$el
    @options.polls.each (single_poll) ->
      #console.log(single_poll.toJSON())
      console.log(single_poll)
      question_bubble = $('<div class="speech_bubble '+single_poll.id+'" id="'+single_poll.id+'"></div>')
      bubble_direction = if (single_poll.attributes.poll_type == 'user') then 'from_right' else 'from_left'
      question_bubble.addClass(bubble_direction)
      question_bubble.css
        left: "#{single_poll.attributes.map_x_coord}px"
        top: "#{single_poll.attributes.map_y_coord}px"
      mapElement.append(question_bubble)

  populatePoll: ->
    $(".poll-info").remove()
    poll = @options.polls.at(@count)
    #pollElement.html(@pollTemplate(poll.toJSON()))
    if(poll)
      newText = ".speech_bubble." + poll.id
      console.log(newText)
      currentBubble = $(newText)
      console.log(currentBubble)
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

