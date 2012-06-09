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
    @polls = options.polls
    $(@el).html(@template({state_graphic_path: "/assets/#{@state.toLowerCase()}_outline.png"}))
    

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
        "touchstart .pollNext" : "selectBubble"
        "touchend .speech_bubble" : "replacePoll"
    else
      events =
        "click .destroy" : "destroy"
        "click .pollAnswer" : "nextPoll"
        "click .pollNext" : "populatePoll"
        "click .pollTest" : "populatePoll"
        "hover .speech_bubble" : "hover"
        "hover .pollAnswer" : "selectBubble"
        "hover .pollNext" : "selectBubble"
        "click .speech_bubble" : "replacePoll"

  destroy: () ->
    #@model.destroy()
    this.remove()

    return false

  hover:(e) ->
    $(e.currentTarget).toggleClass("hl_temp")

  selectBubble:(e) ->
    @highlightBubble(e.currentTarget.getAttribute('data-pollid'))
  
  highlightBubble: (pollID) ->
    $("#speech_bubble_#{pollID}").toggleClass("hl_temp")

  render: ->
    @populateMap()
    @generatePips()
    @populatePoll()
    return this
  
  
  populateMap: ->
    mapElement = @$el
    @options.polls.each (single_poll) ->
      console.log("populateMap")
      console.log(single_poll)
      pollID = single_poll.attributes.poll_id
      question_bubble = $('<div class="speech_bubble" id="speech_bubble_'+pollID+'" data-pollid="'+pollID+'"></div>')
      if (single_poll.attributes.poll_type == 'user')
        bubble_direction = 'from_right'
        question_bubble.css
          left: "#{single_poll.attributes.map_x_coord}px"
          top: "#{single_poll.attributes.map_y_coord}px"
      else
        bubble_direction = 'from_left'
        question_bubble.css
          left: "#{single_poll.attributes.map_x_coord + 55}px"
          top: "#{single_poll.attributes.map_y_coord}px"
      question_bubble.addClass(bubble_direction)
      mapElement.append(question_bubble)

  populatePoll: ->
    $(".poll-question-container").remove()
    $(".poll-result").remove()
    @count++
    if(! @options.polls.at(@count))
      @count = 0
    poll = @options.polls.at(@count)
    console.log("Poll here")
    console.log(poll)
    if(poll)
      pollID = poll.attributes.poll_id
      currentBubble = $("#speech_bubble_" + pollID)
      $(".speech_bubble").removeClass("hl")
      $(".speech_bubble").removeClass("hl_temp")
        #Toggle would be better here!
      currentBubble.addClass("hl")

      $(@el).append(@pollTemplate(poll.toJSON()))
      @resultView = new AsqUs.Views.Polls.ResultView(model: poll)
      $('#poll_results_container').html(@resultView.render().el).hide()
      @updatePips(@count)
      @highlightBubble(pollID)

#How to get the id of question bubble, and then switch to that question
  replacePoll:(e) ->
    $(".speech_bubble").removeClass("hl_temp")
    $(".poll-question-container").remove()
    $(".poll-result").remove()
    newID = e.currentTarget.getAttribute('data-pollid')
    poll = @options.polls.get(newID)
    console.log("check")
    console.log(poll)
    currentBubble = $("#speech_bubble_" + poll.attributes.id)
    $(".speech_bubble").removeClass("hl")
    currentBubble.addClass("hl")
    console.log(currentBubble)
    $(@el).append(@pollTemplate(poll.toJSON()))
    @resultView = new AsqUs.Views.Polls.ResultView(model: poll)
    $('#poll_results_container').html(@resultView.render().el).hide()
    @count++
    if(! @options.polls.at(@count))
      @count = 0
    @updatePips(@count)
    

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
      $("#poll_results_container").fadeOut('fast', ->
        $(".poll-question-container").fadeIn('fast')
      )
    #@populatePoll()
    @showResults(pollID)

  showResults:(pollID) ->
    $(".pollAnswer").attr("disabled", "disabled")
    $('#poll_results_container').html(@resultView.render().el).hide()
    poll = @options.polls.get(pollID)
    if(!poll)
      return
    $(".poll-question-container").fadeOut('fast', ->
      $("#poll_results_container").fadeIn('fast')
    )
    @resultView.generatePlots()


  generatePips: ->
    @pips = $('<div class="pips"></div>')
    @pips.css({width: (22 * @polls.length) + 'px'})
    pip = $('<div class="pip"></div>')
    that = this
    pip.clone().attr('id', "pip_#{i}").appendTo(that.pips) for i in [0..@polls.length-1]
    $(@el).append(@pips)
    console.log 'Added pips'

  updatePips: (index) ->
    console.log "Updating pips with #{index}"
    $('.pip').removeClass('current')
    $("#pip_#{index}").addClass('current')
    console.log $("#pip_#{index}")


