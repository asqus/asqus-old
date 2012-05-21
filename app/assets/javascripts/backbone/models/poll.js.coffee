class AsqUs.Models.Poll extends Backbone.Model
  paramRoot: 'poll'

  defaults:
    title: null
    prompt: null
    category: null
    published: null

class AsqUs.Collections.PollsCollection extends Backbone.Collection
  model: AsqUs.Models.Poll
  url: '/polls'
