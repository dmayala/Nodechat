Marionette = require 'backbone.marionette'

class User extends Marionette.ItemView
  template: require '../templates/show/user' 
  className: 'row'

module.exports = User