ChatApp.module('Entities', function(Entities, App, Backbone, Marionette, $, _) {

  Entities.Message = Backbone.Model.extend({
    urlRoot: 'messages',
    defaults: {
      'username': '',
      'content': ''
    }
  });

  Entities.Messages = Backbone.Collection.extend({
    url: 'messages',
    model: Entities.Message
  });

  var API = {
    getMessageEntity: function(id) {
      var message = new Entities.Message({ id: id });
      var defer = $.Deferred();
      message.fetch({
        success: function(data) {
          defer.resolve(data);
        },
        error: function(data) {
          defer.resolve(undefined);
        }
      });
      return defer.promise();
    },

    getMessageEntities: function() {
      var messages = new Entities.Messages();
      messages.fetch();
      return messages;
    }
  };

  App.reqres.setHandler('message:entity', function() {
    return API.getMessageEntities();
  });

  App.reqres.setHandler('message:entities', function() {
    return API.getMessageEntities();
  });

});