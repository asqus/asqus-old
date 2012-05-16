class AsqUs.Models.Group extends Backbone.Model
  paramRoot: 'group'

  defaults:
    title: null
    members: null

class AsqUs.Collections.GroupsCollection extends Backbone.Collection
  model: AsqUs.Models.Group
  url: '/groups'
