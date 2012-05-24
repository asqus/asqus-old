class AsqUs.Models.Poll extends Backbone.Model
  paramRoot: 'poll'

  defaults:
    title: null
    prompt: null
    category: null
    published: null
    creator_id: null
    map_x_coord: 0
    map_y_coord: 0
    

class AsqUs.Collections.PollsCollection extends Backbone.Collection
  model: AsqUs.Models.Poll
  url: '/polls'
