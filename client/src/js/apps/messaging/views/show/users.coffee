Marionette = require 'backbone.marionette'

class Users extends Marionette.CompositeView
  template: require '../templates/show/users'
  childView: require './user'
  childViewContainer: '.users'

  collectionEvents:
    add: 'updateUserCount'
    remove: 'updateUserCount'

  updateUserCount: -> @$el.find('span').text @collection.length
  onRender: -> @updateUserCount()

module.exports = Users