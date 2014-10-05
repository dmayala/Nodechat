Backbone = require 'backbone'

class Message extends Backbone.Model
  urlRoot: 'messages',
  defaults:
    'author': '',
    'text': ''

module.exports = Message