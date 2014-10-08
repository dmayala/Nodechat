Marionette = require 'backbone.marionette'
Radio = require '../../radio'

class Module extends Marionette.Module
  socket = io();
  socket.emit 'login'

  socket.on 'serverMessage', (message) ->
    Radio.vent.trigger 'global', 'socket:inboundMsg', message

  Radio.vent.on 'global', 'socket:outboundMsg', (message) ->
    socket.emit 'clientMessage', message

module.exports = Module
