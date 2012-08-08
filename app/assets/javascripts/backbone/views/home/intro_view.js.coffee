AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.IntroView extends Backbone.View

  className: "intro_view"

  initialize: (options) ->
    @num_polls_completed = 0
    $(@el).html(@introTemplate)

  introTemplate: JST["backbone/templates/home/intro_view"]

  events: ->
    "submit form.askQuestion" : "showQuestion"
    "hover #introOverlay" : "hideBubbles"
  
  showQuestion: ->
    console.log("check it")

  hideBubbles: ->
    if($(".bubble_fade"))
      $(".bubble_fade").fadeToggle(600)
      console.log("bubble_fade")

  populateMap: ->
    mapElement = @$el.children('.intro_container').children('#introOverlay').children('#tablet')
    console.log("populateMap")
    console.log(mapElement)
    pollID = 5
    i = 4
    question_bubble = $('<div class="speech_bubble hl_temp from_right"></div>')
    bubble_direction = 'from_right'
    question_bubble.css
      left: "200px"
      top: "140px"
    mapElement.append(question_bubble)
    #question_bubble.addClass('fade')
    question_bubble2 = $('<div class="speech_bubble hl_temp from_right bubble_fade"></div>')
    question_bubble2.css
      left: "100px"
      top: "100px"
    mapElement.append(question_bubble2)
    question_bubble3 = $('<div class="speech_bubble hl_temp from_right bubble_fade"></div>')
    question_bubble3.css
      left: "140px"
      top: "160px"
    mapElement.append(question_bubble3)
    question_bubble4 = $('<div class="speech_bubble hl_temp from_right bubble_fade"></div>')
    question_bubble4.css
      left: "305px"
      top: "80px"
    mapElement.append(question_bubble4)
    question_bubble5 = $('<div class="speech_bubble hl_temp from_right bubble_fade"></div>')
    question_bubble5.css
      left: "270px"
      top: "210px"
    mapElement.append(question_bubble5)


  render: ->
    @populateMap()
    return this
  

