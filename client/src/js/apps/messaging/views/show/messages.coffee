Marionette = require 'backbone.marionette'

class Messages extends Marionette.CollectionView
  className: 'row scrollable maxheight'
  childView: require './message'

  initialize: ->
    _.defer =>
      @$el.scrollTop @$el[0].scrollHeight
      @.on 'add:child', => @$el.scrollTop @$el[0].scrollHeight
    
module.exports = Messages