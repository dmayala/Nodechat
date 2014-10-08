Marionette = require 'backbone.marionette'

class Messages extends Marionette.CollectionView
  className: 'container'
  childView: require './message'

module.exports = Messages