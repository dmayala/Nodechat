Backbone = require 'backbone'
configureStorage = require '../../config/storage/localstorage'

class Users extends Backbone.Collection
  url: 'users',
  model: require '../models/user'

configureStorage Users
module.exports = Users