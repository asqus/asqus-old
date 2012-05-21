AsqUs.Views.Reps ||= {}

class AsqUs.Views.Reps.HomeView extends Backbone.View
  template: JST["backbone/templates/reps/home"]
  
  el: '#content'

  render: ->
    console.log this.el
    $(@el).html(@template(@model.toJSON() ))
    #this.$('#nav').html(JST['backbone/templates/reps/_nav'])
    return this
