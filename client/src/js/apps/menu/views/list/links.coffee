Marionette = require 'backbone.marionette'

class Links extends Marionette.CompositeView
  template: require '../templates/list/links'
  tagName: 'div'
  className: 'navmenu navmenu-default navmenu-fixed-left'
  childView: require './link'
  childViewContainer: 'ul'

module.exports = Links