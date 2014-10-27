# require dependencies
Marionette = require 'backbone.marionette'
Radio = require './radio'

# require modules
MenuModule = require './apps/menu/module'
MessagingModule = require './apps/messaging/module'
SocketsModule = require './apps/sockets/module'

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

# window events
$(window)
  .focus -> Radio.vent.trigger 'socket:changeStatus', true
  .blur -> Radio.vent.trigger 'socket:changeStatus', false

App.getCurrentRoute = -> Backbone.history.fragment

App.on 'start', ->
  Backbone.history.start() if Backbone.history
  Radio.vent.trigger('messaging:show') if @getCurrentRoute() is ''

module.exports = App