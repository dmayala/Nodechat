Marionette = require 'backbone.marionette'

# helpers
require '../../../../common/helpers/time_format'

class Message extends Marionette.ItemView
  template: require '../templates/show/message' 

module.exports = Message