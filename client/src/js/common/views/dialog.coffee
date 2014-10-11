Marionette = require 'backbone.marionette'

class Dialog extends Marionette.LayoutView
  template: require './templates/dialog'
  className: 'modal-dialog'

  initialize: (options) ->
    @title = options.title

  regions:
    modal: '.modal-body'

  serializeData: =>
    'title': @title

module.exports = Dialog
