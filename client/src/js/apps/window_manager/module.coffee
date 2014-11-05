Marionette = require 'backbone.marionette'
Radio = require '../../radio'
Favico = require 'favico'

class Module extends Marionette.Module

  # manage favicon
  favicon = new Favico animation: 'none'
  msgCount = 0

  resetTitle = ->
    $('title').text 'Nodechat'
    favicon.reset()
    msgCount = 0

  changeTitle = ->
    $('title').text 'Unread messages!'
    msgCount = msgCount + 1
    favicon.badge msgCount

  # Trigger status changes based on window focus/blur
  $(window)
    .focus ->
      resetTitle()
      Radio.vent.trigger 'socket:changeStatus', true
    .blur -> Radio.vent.trigger 'socket:changeStatus', false

  # Notify users of new unread messages
  Radio.vent.on 'messaging:unread:msg', -> changeTitle()


module.exports = Module
