AsqUs.Views.Home ||= {}

class AsqUs.Views.Home.DemoView extends Backbone.View

  className: 'demo_view'

  doneTemplate: JST["backbone/templates/home/done"]

  events: ->

  initialize: (options) ->
    @polls = options.polls
  

  render: ->
    @intro_view = new AsqUs.Views.Home.IntroView()
    $("#introPane").html(@intro_view.render().el)

    @ask_view = new AsqUs.Views.Home.AskView()
    $("#ask").html(@ask_view.render().el)

    @answer_view = new AsqUs.Views.Home.AnswerView(polls: @polls)
    $("#answer").html(@answer_view.render().el)

    @community_view = new AsqUs.Views.Home.CommunityView()
    $("#community").html(@community_view.render().el)

    return this

  
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

    

