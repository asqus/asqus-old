AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.MapView extends Backbone.View

  className: "map"

  initialize: (options) ->
    agent = navigator.userAgent.toLowerCase()
    if agent.match(/ip(hone|od|ad)/i) or agent.match(/android/i)
      console.log("mobile!")
    else
      console.log("not mobile")
    @state = options.state
    @count = options.count
    $(@el).html(@template({state_graphic_path: "/assets/#{@state.toLowerCase()}_outline.gif"}))

  template: JST["backbone/templates/home/map_view"]
  pollTemplate: JST["backbone/templates/home/poll_view"]
  resultTemplate: JST["backbone/templates/home/result_view"]
  

  events: ->
    agent = navigator.userAgent.toLowerCase()
    if agent.match(/ip(hone|od|ad)/i) or agent.match(/android/i)
      events =
        "touchstart .pollAnswer" : "hoverInverse"
        "touchend .pollAnswer" : "nextPoll"
        "touchend .pollNext" : "populatePoll"
        "touchend .pollTest" : "populatePoll"
        "touchstart .speech_bubble" : "hover"
        "touchstart .pollNext" : "hoverInverse"
        "touchend .speech_bubble" : "replacePoll"
    else
      events =
        "click .destroy" : "destroy"
        "click .pollAnswer" : "nextPoll"
        "click .pollNext" : "populatePoll"
        "click .pollTest" : "populatePoll"
        "hover .speech_bubble" : "hover"
        "hover .pollAnswer" : "hoverInverse"
        "hover .pollNext" : "hoverInverse"
        "click .speech_bubble" : "replacePoll"

  destroy: () ->
    #@model.destroy()
    this.remove()

    return false

  hover:(e) ->
    $(e.currentTarget).toggleClass("hl_temp")

  hoverInverse:(e) ->
    $(e.currentTarget).toggleClass("btn-inverse")

  render: ->
    @populateMap()
    @populatePoll()
    return this
  
  
  populateMap: ->
    mapElement = @$el
    @options.polls.each (single_poll) ->
      console.log("populateMap")
      console.log(single_poll)
      pollID = single_poll.attributes.poll_id
      question_bubble = $('<div class="speech_bubble '+pollID+'" id="'+pollID+'"></div>')
      bubble_direction = if (single_poll.attributes.poll_type == 'user') then 'from_right' else 'from_left'
      question_bubble.addClass(bubble_direction)
      question_bubble.css
        left: "#{single_poll.attributes.map_x_coord}px"
        top: "#{single_poll.attributes.map_y_coord}px"
      mapElement.append(question_bubble)

  populatePoll: ->
    $(".poll-info").remove()
    $(".poll-result").remove()
    @count++
    if(! @options.polls.at(@count))
      @count = 0
    poll = @options.polls.at(@count)
    console.log("Poll here")
    console.log(poll)
    if(poll)
      newText = ".speech_bubble." + poll.attributes.poll_id
      currentBubble = $(newText)
      $(".speech_bubble").removeClass("hl")
        #Toggle would be better here!
      currentBubble.addClass("hl")

      $(@el).append(@pollTemplate(poll.toJSON()))

#How to get the id of question bubble, and then switch to that question
  replacePoll:(e) ->
    $(e.currentTarget).removeClass("hl_temp")
    $(".poll-info").remove()
    $(".poll-result").remove()
    newID = e.currentTarget.id
    poll = @options.polls.get(newID)
    console.log("check")
    console.log(poll)
    currentBubble = $(".speech_bubble." + poll.id)
    $(".speech_bubble").removeClass("hl")
    currentBubble.addClass("hl")
    console.log(currentBubble)
    $(@el).append(@pollTemplate(poll.toJSON()))


  nextPoll:(clicked) ->
    console.log("EL")
    console.log(@el)
    if($(clicked.currentTarget).hasClass("disabled"))
      return false
    $(clicked.currentTarget).toggleClass("btn-inverse")
    $(clicked.currentTarget).addClass("btn-warning")
    pollID = clicked.currentTarget.dataset.pollid
    answerID = clicked.currentTarget.dataset.answerid
    console.log("check check")
    console.log(pollID)
    console.log(answerID)
    @count++
    if(! @options.polls.at(@count))
      @count = 0
    url = "/polls/"+pollID+"/vote/"+answerID+".json"
    console.log(url)
    data = null
    votePost = $.get url
    votePost.success (data) ->
      $(".pollAnswer").removeAttr("disabled", "disabled")
      $(clicked.currentTarget).removeClass("btn-warning")
      $(clicked.currentTarget).addClass("btn-success")
      $(".pollAnswer").addClass("disabled")
      if($(".pollAnswer").hasClass("btn-inverse"))
        $(".pollAnswer").removeClass("btn-inverse")
      $(".pollAnswer").attr("disabled", "disabled")
    votePost.error (jqXHR, textStatus, errorThrown) ->
      alert "Vote never made it, try again!"
      $(".pollAnswer").removeAttr("disabled", "disabled")
      $(clicked.currentTarget).removeClass("btn-warning")
      $(".poll-result").remove()
    #@populatePoll()
    @showResults(pollID)

  showResults:(pollID) ->
    $(".pollAnswer").attr("disabled", "disabled")
    poll = @options.polls.get(pollID)
    if(poll)
      $(".pollStats").append(@resultTemplate(poll.toJSON()))
      #$(@el).append(@resultTemplate(poll.toJSON()))











