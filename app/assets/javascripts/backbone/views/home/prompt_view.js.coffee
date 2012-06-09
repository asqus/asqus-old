AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.PromptView extends Backbone.View

  template: JST["backbone/templates/home/prompt_view"]
  resultTemplate: JST["backbone/templates/home/result_view"]

  initialize: ->
    @count = 0

  events: ->
    agent = navigator.userAgent.toLowerCase()
    if agent.match(/ip(hone|od|ad)/i) or agent.match(/android/i)
      events =
        "touchstart .pollAnswer" : "hover"
        "touchend .pollAnswer" : "answerPoll"
    else
      events =
        "click .pollAnswer" : "answerPoll"
        "hover .pollAnswer" : "hover"

  hover:(e) ->
    $(e.currentTarget).toggleClass("btn-inverse")

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (user) =>
        @model = user
        window.location.hash = "/#{@model.id}"
    )

  answerPoll:(e) ->
      #Ensure buttons available
    if($(e.currentTarget).hasClass("disabled"))
      return false
      #Button highlighting
    $(e.currentTarget).toggleClass("btn-inverse")
    $(e.currentTarget).addClass("btn-warning")
      #Get pollID and answerID. pollID should actually be known here
      # @model.id or etc. TODO
    pollID = e.currentTarget.dataset.pollid
    answerID = e.currentTarget.dataset.answerid
      #Create url 
    url = "/polls/"+pollID+"/vote/"+answerID+".json"
    data = null
    votePost = $.get url
      #Request callbacks
    votePost.success (data) ->
      $(".pollAnswer").removeAttr("disabled", "disabled")
      $(e.currentTarget).removeClass("btn-warning")
      $(e.currentTarget).addClass("btn-success")
      $(".pollAnswer").addClass("disabled")
      if($(".pollAnswer").hasClass("btn-inverse"))
        $(".pollAnswer").removeClass("btn-inverse")
      $(".pollAnswer").attr("disabled", "disabled")
    votePost.error (jqXHR, textStatus, errorThrown) ->
      alert "Vote never made it, try again!"
      $(".pollAnswer").removeAttr("disabled", "disabled")
      $(e.currentTarget).removeClass("btn-warning")
      $(".poll-result").remove()
    @showResults()
  
  showResults: ->
    $(".pollAnswer").attr("disabled", "disabled")
    if(@model)
      $(".poll-result").append(@resultView.render().el).hide().slideDown('fast')
      $(".pollSkip").remove()
      @resultView.generatePlots()

  render: ->
    @resultView = new AsqUs.Views.Polls.ResultView(model: @model)
    $(@el).html(@template(@model.toJSON() ))
    return this


