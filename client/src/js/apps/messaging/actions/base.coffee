Marionette = require 'backbone.marionette'
Radio = require '../../../radio'
MessageEntity  = require '../entities/message'
UserEntity  = require '../entities/user'

class BaseController extends Marionette.Controller

  initialize: ->
    MessageEntity.initialize()
    UserEntity.initialize()
    @setHandlers()

  setHandlers: ->
    Radio.vent.on 'messaging:show', =>
      @showMessaging()

module.exports = BaseController
