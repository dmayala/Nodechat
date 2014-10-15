Marionette = require 'backbone.marionette'

class Users extends Marionette.CollectionView
  className: 'container'
  childView: require './user'

module.exports = Users