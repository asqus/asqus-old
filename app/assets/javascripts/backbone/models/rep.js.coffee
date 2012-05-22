class AsqUs.Models.Rep extends Backbone.Model
  paramRoot: 'rep'
  
  defaults:
    user:
      first_name: null
      last_name: null
    district: null
    
  initialize: ->
    console.log 'RepModel init'

class AsqUs.Collections.RepsCollection extends Backbone.Collection
  model: AsqUs.Models.Rep
  url: '/reps'
  

