Backbone = require 'backbone'

class Messages extends Backbone.Collection
  url: 'api/messages',
  model: require '../models/message'

module.exports = Messages