Marionette = require 'backbone.marionette'
Radio = require '../../radio'

class Module extends Marionette.Module
  socket = io();
  socket.emit 'login'

  socket.on 'setPersonalId', (id) ->
    Radio.vent.trigger 'global', 'messaging:personalId', id

  socket.on 'serverMessage', (message) ->
    Radio.vent.trigger 'global', 'socket:newUser', message.newUser
    Radio.vent.trigger 'global', 'socket:inboundMsg', message

  socket.on 'leave', (message) ->
    Radio.vent.trigger 'global', 'socket:inboundMsg', message
    Radio.vent.trigger 'global', 'socket:leaveUser', message.user.id

  socket.on 'change:name:success', (message) ->
    Radio.vent.trigger 'global', 'socket:inboundMsg', message
    Radio.vent.trigger 'global', 'socket:changeUser', message.user

  Radio.vent.on 'global', 'socket:outboundMsg', (message) ->
    socket.emit 'clientMessage', message

  Radio.vent.on 'global', 'socket:changeName', (user) ->
    socket.emit 'change:name', user


module.exports = Module
