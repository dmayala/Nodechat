Marionette = require 'backbone.marionette'
DialogView = require '../views/dialog'
bootstrap = require 'bootstrap'

class Dialog extends Marionette.Region

  show: (view, options) ->
    dialogView = new DialogView({ title: view.title })
    Marionette.Region::show.call(@, dialogView, options)
    dialogView.modal.show(view)

  onShow: (view) ->
    @$el.one 'hidden.bs.modal', @closeDialog
    @$el.modal backdrop: true, show: true

  onBeforeEmpty: ->
    @$el.modal 'hide'

  closeDialog: =>
    @$el.off 'hidden.bs.modal'
    @empty()
    @$el.modal 'hide'

module.exports = Dialog
