class AsqUs.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    first_name: null
    last_name: null
    email: null
    zipcode: null
    password: null

class AsqUs.Collections.UsersCollection extends Backbone.Collection
  model: AsqUs.Models.User
  url: '/users'
