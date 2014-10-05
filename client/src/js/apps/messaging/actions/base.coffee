Marionette = require 'backbone.marionette'
Radio = require '../../../radio'
MessageEntity  = require '../entities/message'

class BaseController extends Marionette.Controller

  initialize: ->
    MessageEntity.initialize()
    @setHandlers()

  setHandlers: ->
    Radio.vent.on 'global', 'messaging:show', =>
      @showMessaging()

module.exports = BaseController
