Marionette = require 'backbone.marionette'
Backbone.Syphon = require 'backbone.syphon'

class Form extends Marionette.ItemView
  template: require '../templates/common/form'

  events:
    'click button.js-submit': 'submitClicked'

  submitClicked: (e) ->
    e.preventDefault()
    data = Backbone.Syphon.serialize @
    @trigger 'form:submit', data

  onFormDataInvalid: (errors) ->
    clearFormErrors = =>
      $form = @$el.find 'form'
      $form.find('.help-block').each -> $(@).remove()
      $form.find('.has-error').each -> $(@).removeClass 'has-error'

    markErrors = (val, key) =>
      $controlGroup = @$el.find("#user-#{key}").parent()
      $errorEl = $('<span>', { class: 'help-block', text: val })
      $controlGroup.append($errorEl).addClass 'has-error'

    clearFormErrors()
    _.each errors, markErrors

module.exports = Form