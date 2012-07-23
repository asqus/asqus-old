AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.DemoView extends Backbone.View

  className: 'hello'

  initialize: (options) ->
    @polls = options.polls
    @num_polls_completed = 0
    console.log(@polls)
    

  template: JST["backbone/templates/home/map_view"]
  doneTemplate: JST["backbone/templates/home/done"]
  pollTemplate: JST["backbone/templates/home/poll_view"]
  siteInfoTemplate: JST["backbone/templates/home/site_info"]
  

  events: ->
    "click .pollAnswer" : "pollAnswer"
    "click .pollNext" : "nextPoll"


  nextPoll: ->
    @_renderNextPoll()
    @$el.find('.card').toggleClass('flip')
        
  
  _renderNextPoll: ->
    @count++
    if(! @options.polls.at(@count))
      @count = 0
    poll = @options.polls.at(@count)
    if (poll)
      @$el.html(@pollTemplate(poll.toJSON()))
      @resultView ||= new AsqUs.Views.Polls.ResultView(model: poll)
      @resultView.setModel(poll)
      @_initializePollResults(poll)


  hover:(e) ->
    $(e.currentTarget).toggleClass("hl_temp")

  render: ->
    @_renderNextPoll()
    return this


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
    

  pollAnswer: (clicked) ->
    if($(clicked.currentTarget).hasClass("disabled"))
      return false
    $(clicked.currentTarget).toggleClass("btn-inverse")
    $(clicked.currentTarget).addClass("btn-warning")
    pollID = clicked.currentTarget.dataset.pollid
    answerID = clicked.currentTarget.dataset.answerid
    @num_polls_completed++
    @count++
    if(! @options.polls.at(@count))
      @count = 0
    url = "/polls/"+pollID+"/vote/"+answerID+".json"
    console.log(url)
    data = null

    poll = @polls.get(pollID)
    console.log(poll)
    current_totals = poll.get('totals')
    
    if current_totals
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
    $(".pollAnswer").attr("disabled", "disabled")
    
    @$el.find('.card .back.face').html(@resultView.render().el)
    @resultView.generatePlots()
    @$el.find('.card .back.face').show()
    @$el.find('.card').toggleClass('flip')


  _initializePollResults:(poll) ->
    if(!poll)
      return
    $('.card .back.face').html(@resultView.render().el)

  
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
        $('.ui-widget-overlay').hide().fadeIn()
      height: 380
      width: 600
      modal: true
    @doneModal = $('<div></div>').html(@doneTemplate()).dialog(modalArgs)
    emailSignupListener()
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
    

