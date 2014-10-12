Backbone = require 'backbone'
Backbone.Picky = require 'backbone.picky'

class Links extends Backbone.Collection
  model: require '../models/link'

  initialize: ->
    singleSelect = new Backbone.Picky.SingleSelect @
    _.extend @, singleSelect

module.exports = Links
