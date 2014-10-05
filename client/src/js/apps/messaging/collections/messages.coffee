Backbone = require 'backbone'

class Messages extends Backbone.Collection
  url: 'messages',
  model: require '../models/message'

module.exports = Messages