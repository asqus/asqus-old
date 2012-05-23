AsqUs.Views.Reps ||= {}

class AsqUs.Views.Reps.CommunityView extends Backbone.View
  template: JST["backbone/templates/reps/community"]
  
  el: '#content'

  render: ->
    repList = new AsqUs.Collections.RepsCollection;
    repList.fetch(
      success: ->
        console.log 'Replist: '
        console.log repList
        repView = new AsqUs.Views.Reps.IndexView({ reps: repList });
        $('#rep_list').html(repView.render().el)
      error: ->
        new Error({ message: 'Error loading representatives.' })
    );
    
    $(@el).html(@template(@model.toJSON() ))
    #this.$('#nav').html(JST['backbone/templates/reps/_nav'])
    return this
    
  showRep: (id) ->
    alert(id)
