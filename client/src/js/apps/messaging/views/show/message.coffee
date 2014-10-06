Marionette = require 'backbone.marionette'

class Message extends Marionette.ItemView
  template: require '../templates/show/message' 

module.exports = Message