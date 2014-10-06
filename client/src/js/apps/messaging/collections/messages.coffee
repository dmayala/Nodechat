Backbone = require 'backbone'
configureStorage = require '../../config/storage/localstorage'

class Messages extends Backbone.Collection
  url: 'messages',
  model: require '../models/message'

configureStorage Messages
module.exports = Messages