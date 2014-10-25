Marionette = require 'backbone.marionette'
Radio = require '../../radio'

class Module extends Marionette.Module
  socket = io();
  socket.emit 'login'

  socket.on 'setPersonalId', (id) ->
    Radio.vent.trigger 'messaging:personalId', id

  socket.on 'serverMessage', (message) ->
    Radio.vent.trigger 'socket:newUser', message.newUser
    Radio.vent.trigger 'socket:inboundMsg', message

  socket.on 'leave', (message) ->
    Radio.vent.trigger 'socket:inboundMsg', message
    Radio.vent.trigger 'socket:leaveUser', message.user.id

  socket.on 'change:name:success', (message) ->
    Radio.vent.trigger 'socket:inboundMsg', message
    Radio.vent.trigger 'socket:changeUser', message.user

  Radio.vent.on 'socket:outboundMsg', (message) ->
    socket.emit 'clientMessage', message

  Radio.vent.on 'socket:changeName', (user) ->
    socket.emit 'change:name', user


module.exports = Module
