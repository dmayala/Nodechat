Backbone = require 'backbone'
configureStorage = require '../../config/storage/localstorage'

class User extends Backbone.Model
  urlRoot: 'users',
  defaults:
    'nickname': ''

configureStorage User
module.exports = User