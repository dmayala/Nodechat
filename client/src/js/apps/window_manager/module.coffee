Marionette = require 'backbone.marionette'
Radio = require '../../radio'

class Module extends Marionette.Module

  # Trigger status changes based on window focus/blur
  $(window)
    .focus ->
      $('title').text 'Nodechat' 
      Radio.vent.trigger 'socket:changeStatus', true
    .blur -> Radio.vent.trigger 'socket:changeStatus', false

  # Notify users of new unread messages
  Radio.vent.on 'messaging:unread:msg', ->
    $('title').text 'New message!'

module.exports = Module
