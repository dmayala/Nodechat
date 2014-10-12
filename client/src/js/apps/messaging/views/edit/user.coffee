Marionette = require 'backbone.marionette'
FormView = require '../common/form'

class User extends FormView
  title: 'Change Username'

  onRender: ->
    @$('.js-submit').text 'Edit username'

module.exports = User