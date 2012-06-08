AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.MapView extends Backbone.View

  className: "map"

  initialize: (options) ->
    @state = options.state
    @count = options.count
    @polls = options.polls
    $(@el).html(@template({state_graphic_path: "/assets/#{@state.toLowerCase()}_outline.gif"}))
    

  template: JST["backbone/templates/home/map_view"]
  pollTemplate: JST["backbone/templates/home/poll_view"]
  resultTemplate: JST["backbone/templates/polls/result"]
  
  events:
    "click .destroy" : "destroy"
    "click .pollAnswer" : "nextPoll"
    "click .nextQuestion" : "populatePoll"
    "click .pollTest" : "populatePoll"
    "hover .speech_bubble" : "hover"
    "hover .pollAnswer" : "hoverInverse"
    "hover .nextQuestion" : "hoverInverse"
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
    if($(clicked.currentTarget).hasClass("disabled"))
      return false
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
      #console.log(data)
      $(clicked.currentTarget).removeClass("btn-warning")
      $(clicked.currentTarget).addClass("btn-success")
      $(".pollAnswer").addClass("disabled")
      if($(".pollAnswer").hasClass("btn-inverse"))
        $(".pollAnswer").removeClass("btn-inverse")
      $(".pollAnswer").attr("disabled", "disabled")
    votePost.error (jqXHR, textStatus, errorThrown) ->
      alert "Vote never made it, try again!"
      $(clicked.currentTarget).removeClass("btn-warning")
      $(".poll-result").remove()
    #@populatePoll()
    @showResults(pollID)

  showResults: (pollID) ->
  
    poll = @polls.get(pollID)
    if(!poll)
      return
    resultView = new AsqUs.Views.Polls.ResultView(model: poll)
    $('#poll_results_container').html(resultView.render().el)
    resultView.generatePlots()
      
#      plot_data = poll.attributes.totals.map (val) ->
#        return { label: val.option, data: val.count }
#      #data = [ { label: "Series1",  data: 10}, { label: "Series2",  data: 30}, { label: "Series3",  data: 90}, { label: "Series4",  data: 5}, { label: "Series5",  data: 20} ]
#      plot_options =
#        series:
#          pie:
#            show: true
#            radius: 1
#            label:
#              radius: 0.7
#              formatter: (label, series) ->
#                return '<div class="plot-label"><div class="plot-label-label">'+label+'</div>'+
#                '<div class="plot-label-series">'+ Math.round(series.percent) + "%</div></div>"
#        colors: [
#          '#6D6'
#          '#D66'
#        ] 
#        legend:
#          show: true
#          labelFormatter: (label, series) ->
#            return label + ' ' + Math.round(series.percent) + '%'
#        grid:
#          hoverable: true
#          clickable: true
#        highlight:
#          opacity: 0.9
#      $.plot($("#poll_#{pollID}_result_plot"), plot_data, plot_options);
      
     
      

