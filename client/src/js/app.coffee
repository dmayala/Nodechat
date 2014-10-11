# require dependencies
Marionette = require 'backbone.marionette'
Radio = require './radio'

# require modules
MessagingModule = require './apps/messaging/module'
SocketsModule = require './apps/sockets/module'

# create application namespace
App = new Marionette.Application();

# add regions
App.addRegions
  messagingRegion: '#messaging-region'
  dialogRegion:
    selector: '#dialog-region',
    regionClass: require './common/regions/dialog'

# add modules
App.module 'messaging', MessagingModule
App.module 'sockets', SocketsModule

App.getCurrentRoute = -> Backbone.history.fragment

App.on 'start', ->
  Backbone.history.start() if Backbone.history
  Radio.vent.trigger('global', 'messaging:show') if @getCurrentRoute() is ''

module.exports = App