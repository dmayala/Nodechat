Backbone = require 'backbone'

class Users extends Backbone.Collection
  url: 'api/users',
  model: require '../models/user'

module.exports = Users