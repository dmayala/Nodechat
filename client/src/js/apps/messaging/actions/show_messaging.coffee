LayoutShowView = require '../views/show/layout'
Radio = require '../../../radio'

showMessaging = ->
  Backbone.history.navigate 'messaging'
  @options.messagingRegion.show new LayoutShowView()

module.exports = showMessaging