Backbone = require 'backbone'

class Users extends Backbone.Collection
  model: require '../models/user'

module.exports = Users