Marionette = require 'backbone.marionette'

class Users extends Marionette.CompositeView
  template: require '../templates/show/users'
  childView: require './user'
  childViewContainer: '.users'

module.exports = Users