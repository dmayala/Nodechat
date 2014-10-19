Backbone = require 'backbone'

class User extends Backbone.Model
  urlRoot: 'api/users',
  defaults:
    'nickname': 'Guest'

module.exports = User