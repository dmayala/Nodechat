Backbone = require 'backbone'
configureStorage = require '../../config/storage/localstorage'

class Message extends Backbone.Model
  urlRoot: 'messages',
  defaults:
    'timestamp': ''
    'author': '',
    'text': ''

configureStorage Message
module.exports = Message