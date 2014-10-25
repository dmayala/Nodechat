Marionette = require 'backbone.marionette'

class Messages extends Marionette.CollectionView
  childView: require './message'
  className: 'list-group'

  initialize: ->
    _.defer =>
      @$el.scrollTop @$el[0].scrollHeight
      @.on 'add:child', => @$el.scrollTop @$el[0].scrollHeight
    
module.exports = Messages