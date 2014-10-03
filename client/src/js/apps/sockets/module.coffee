Marionette = require 'backbone.marionette'

class Module extends Marionette.Module
  socket = io();
  name = prompt('Enter name') || 'Unknown'
  socket.emit 'login', name

  socket.on 'serverMessage', (data) -> console.log data
  socket.emit 'clientMessage', 'this is a test'

module.exports = Module
