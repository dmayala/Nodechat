# require dependencies
Marionette = require 'backbone.marionette'
Radio = require './radio'

# require modules
MenuModule = require './apps/menu/module'
MessagingModule = require './apps/messaging/module'
SocketsModule = require './apps/sockets/module'
WindowManagerModule = require './apps/window_manager/module'

# create application namespace
App = new Marionette.Application()

# add regions
App.addRegions
  menuRegion: '#menu-region'
  messagingRegion: '#messaging-region'
  dialogRegion:
    selector: '#dialog-region',
    regionClass: require './common/regions/dialog'

# add modules
App.module 'menu', MenuModule
App.module 'messaging', MessagingModule
App.module 'sockets', SocketsModule
App.module 'window_manager', WindowManagerModule

App.getCurrentRoute = -> Backbone.history.fragment

App.on 'start', ->
  Backbone.history.start() if Backbone.history
  Radio.vent.trigger('messaging:show') if @getCurrentRoute() is ''

module.exports = App