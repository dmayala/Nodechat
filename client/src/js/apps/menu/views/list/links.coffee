Marionette = require 'backbone.marionette'

class Links extends Marionette.CompositeView
  template: require '../templates/list/links'
  tagName: 'div'
  className: 'navbar navbar-default navbar-fixed-top'
  childView: require './link'
  childViewContainer: 'ul'

module.exports = Links