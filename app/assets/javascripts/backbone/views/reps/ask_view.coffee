AsqUs.Views.Reps ||= {}

class AsqUs.Views.Reps.AskView extends Backbone.View
  template: JST["backbone/templates/reps/ask"]
  
  el: '#content'

  events: 
    "click #create_poll_button": "loadCreate"
    "submit #new-poll": "save"

  loadCreate: ->
    console.log "loading create"
    $("#create_poll_button").hide() 
    window.router.navigate("ask/new", (trigger: true))

  save: ->
    console.log "updated poll list"
    $("#create_poll_button").show() 
    window.router.navigate("ask", (trigger: true))

  render: ->
    console.log this.el
    $(@el).html(@template(@model.toJSON() ))
    #this.$('#nav').html(JST['backbone/templates/reps/_nav'])
    return this
