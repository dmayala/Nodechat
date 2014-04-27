ChatApp.module('Entities', function(Entities, App, Backbone, Marionette, $, _) {
  Entities.Message = Backbone.Model.extend({
    defaults: {
      'username': '',
      'message': ''
    }
  });

  Entities.Messages = Backbone.Collection.extend({
    model: Entities.Message
  });
});