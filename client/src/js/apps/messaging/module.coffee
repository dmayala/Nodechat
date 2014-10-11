Marionette = require 'backbone.marionette'
Router = require './router'
Controller = require './controller'

class Module extends Marionette.Module
  onStart: ->
    @startMediator()

  startMediator: ->
    @controller = new Controller
      messagingRegion: @app.messagingRegion
      dialogRegion: @app.dialogRegion

    router = new Router { controller: @controller }

module.exports = Module
