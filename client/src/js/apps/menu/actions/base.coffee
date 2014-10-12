Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Radio = require '../../../radio'
LinkEntity = require '../entities/link'

class BaseController extends Marionette.Controller

  initialize: ->
    LinkEntity.initialize()
    @listMenu()
    @setHandlers()

  setHandlers: ->
    Radio.commands.setHandler 'global', 'set:active:menu', (name) =>
      @setActiveMenu name

module.exports = BaseController
