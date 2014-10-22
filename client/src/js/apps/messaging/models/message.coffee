Backbone = require 'backbone'

class Message extends Backbone.Model
  urlRoot: 'api/messages'
  
module.exports = Message