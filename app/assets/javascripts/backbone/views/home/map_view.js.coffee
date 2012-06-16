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
    @num_polls_completed = 0
    $(@el).html(@template({state_graphic_path: "/assets/#{@state.toLowerCase()}_outline.png"}))
    @initModal()
    

  template: JST["backbone/templates/home/map_view"]
  doneTemplate: JST["backbone/templates/home/done"]
  pollTemplate: JST["backbone/templates/home/poll_view"]
  resultTemplate: JST["backbone/templates/home/result_view"]
  siteInfoTemplate: JST["backbone/templates/home/site_info"]
  

  events: ->
    agent = navigator.userAgent.toLowerCase()
    if agent.match(/ip(hone|od|ad)/i) or agent.match(/android/i)
      events =
        "touchstart .pollAnswer" : "selectBubble"
        "touchend .pollAnswer" : "nextPoll"
        "touchend .pollNext" : "populatePoll"
        "touchend .pollTest" : "populatePoll"
        "touchstart .speech_bubble" : "hover"
        "touchstart .pollNext" : "selectBubble"
        "touchend .speech_bubble" : "replacePoll"
        "touchend .pip" : "replacePoll"
    else
      events =
        "click .pollAnswer" : "nextPoll"
        "click .pollNext" : "populatePoll"
        "click .pollTest" : "populatePoll"
        "hover .speech_bubble" : "hover"
        "hover .pollAnswer" : "selectBubble"
        "hover .pollNext" : "selectBubble"
        "click .speech_bubble" : "replacePoll"
        "click .pip" : "replacePoll"


  hover:(e) ->
    $(e.currentTarget).toggleClass("hl_temp")

  selectBubble:(e) ->
    @highlightBubble(e.currentTarget.getAttribute('data-pollid'))
  
  highlightBubble: (pollID) ->
    $("#speech_bubble_#{pollID}").toggleClass("hl_temp")

  render: ->
    @populateMap()
    @populatePoll()
    #$(@el).prepend(@siteInfoTemplate())
    return this
  
  
  populateMap: ->
    mapElement = @$el.children('#state')
    @options.polls.each (single_poll, i) ->
      console.log("populateMap")
      console.log(single_poll)
      pollID = single_poll.attributes.poll_id
      question_bubble = $('<div class="speech_bubble" id="speech_bubble_'+pollID+'" data-pollid="'+pollID+'" data-index="'+i+'"></div>')
      if (single_poll.attributes.poll_type == 'user')
        bubble_direction = 'from_left'
        question_bubble.css
          left: "#{single_poll.attributes.map_x_coord + 55}px"
          top: "#{single_poll.attributes.map_y_coord}px"
      else
        bubble_direction = 'from_right'
        question_bubble.css
          left: "#{single_poll.attributes.map_x_coord}px"
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
    console.log(poll)
    if(poll)
      pollID = poll.attributes.poll_id
      currentBubble = $("#speech_bubble_" + pollID)
      $(".speech_bubble").removeClass("hl")
      $(".speech_bubble").removeClass("hl_temp")
        #Toggle would be better here!
      currentBubble.addClass("hl")

      @$el.find('.poll-wrapper').prepend(@pollTemplate(poll.toJSON()))
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
    @count = e.currentTarget.getAttribute('data-index')
    console.log("ReplacePoll with Poll id: #{newID}")
    poll = @options.polls.get(newID)
    console.log(poll)
    currentBubble = $("#speech_bubble_" + poll.attributes.id)
    $(".speech_bubble").removeClass("hl")
    currentBubble.addClass("hl")
    @$el.find('.poll-wrapper').prepend(@pollTemplate(poll.toJSON()))
    @resultView = new AsqUs.Views.Polls.ResultView(model: poll)
    $('#poll_results_container').html(@resultView.render().el).hide()
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
    @num_polls_completed++
    @count++
    if(! @options.polls.at(@count))
      @count = 0
    url = "/polls/"+pollID+"/vote/"+answerID+".json"
    console.log(url)
    data = null

    poll = @polls.get(pollID)
    current_totals = poll.get('totals')
    
    current_total = current_totals[answerID]
    
    foundIndex = -1  # Index into totals that corresponds to the chosen answer
    answerName = poll.attributes.options[answerID]
    for i in [0..current_totals.length-1]
      if current_totals[i].option == answerName
        foundIndex = i
      
    if foundIndex == -1
      current_totals.push(
        "option": poll.attributes.options[answerID]
        "count": 1
      )
    else
      current_totals[foundIndex].count += 1
    poll.set('totals', current_totals)
    @resultView.model = poll
    
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
    if (@num_polls_completed == 2)
      that = this
      setTimeout ( ->
        that.showDoneModal()
      ), 2000

  
  initModal: ->
    # Preload overlay graphic
    overlay = $('<div class="ui-widget-overlay" style="display:none;"></div>').appendTo(document.body)
    modalArgs =
      autoOpen: false
      resizable: false
      title: false
      show: 'fade'
      hide: 'fold'
      open: ->
        $('.ui-widget-overlay').hide().fadeIn();
      height: 380
      width: 600
      modal: true
    @doneModal = $('<div></div>').html(@doneTemplate()).dialog(modalArgs)
    overlay.remove()

  
  showDoneModal: ->
    @doneModal.dialog('open')


  generatePips: ->
    @pips = $('<div class="pips"></div>')
    @pips.css({width: (44 * @polls.length) + 'px'})
    pip = $('<div class="pip"></div>')
    that = this
    pip.clone().attr('id', "pip_#{i}").attr("data-index", i).attr("data-pollid", @polls.at(i).attributes.id).appendTo(that.pips) for i in [0..@polls.length-1]
    @pips.insertAfter(@$el.find('.poll-question-container'))

  updatePips: (index) ->
    $('.pip').removeClass('current')
    $("#pip_#{index}").addClass('current')


