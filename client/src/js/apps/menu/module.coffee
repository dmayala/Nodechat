Marionette = require 'backbone.marionette'
Controller = require './controller'

class Module extends Marionette.Module
  onStart: ->
    @startMediator()

  startMediator: ->
    @controller = new Controller
      menuRegion: @app.menuRegion

module.exports = Module
