Marionette = require 'backbone.marionette'

class UserAvatar extends Marionette.ItemView

  title: 'Change Avatar'
  template: require '../templates/edit/user_avatar'

  events:
    'click button.js-submit': 'submitClicked'
    'change input[name="file"]': 'showPreview'

  submitClicked: (e) =>
    e.preventDefault()

    fd = new FormData @$el.find('form')[0]
    fd.append 'id', @options.personalId
    $.ajax 'api/users/avatar',
      type: 'POST'
      processData: false
      contentType: false
      data: fd
      dataType: 'json'
      success: (data) => @trigger 'avatar:form:success', data

  showPreview: (e) ->
    input = e.currentTarget
    if input.files and input.files[0]
      reader = new FileReader()

      reader.onload = (e) =>
        @$el.find('#avatar-preview').attr('src', e.target.result)

      reader.readAsDataURL input.files[0]

module.exports = UserAvatar