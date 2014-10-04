Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Radio = require '../../../radio'

class BaseController extends Marionette.Controller

  initialize: ->
    @setHandlers()

  setHandlers: ->

module.exports = BaseController
