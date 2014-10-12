Marionette = require 'backbone.marionette'

class Link extends Marionette.ItemView
  template: require '../templates/list/link'
  tagName: 'li'

  triggers:
    'click a': 'navigate'

  onRender: ->
    @$el.addClass('active') if @model.selected

module.exports = Link
