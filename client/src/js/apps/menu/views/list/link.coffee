Marionette = require 'backbone.marionette'

class Link extends Marionette.ItemView
  template: require '../templates/list/link'
  tagName: 'li'

  triggers:
    'click a': 'navigate'

  onRender: ->
    if @model.selected
      @$el.addClass('active') 
      @$el.find('div').show()

module.exports = Link
