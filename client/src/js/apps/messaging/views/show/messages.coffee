Marionette = require 'backbone.marionette'

class Messages extends Marionette.CollectionView
  childView: require './message'

module.exports = Messages