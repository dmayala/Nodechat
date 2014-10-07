Marionette = require 'backbone.marionette'
Radio = require '../../radio'

class Module extends Marionette.Module
  socket = io();
  name = prompt('Enter name') || 'Unknown'
  socket.emit 'login', name

  socket.on 'serverMessage', (message) ->
    console.log message
    Radio.vent.trigger 'global', 'socket:inboundMsg', message

  Radio.vent.on 'global', 'socket:outboundMsg', (message) ->
    socket.emit 'clientMessage', message

module.exports = Module
