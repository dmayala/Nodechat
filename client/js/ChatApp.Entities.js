ChatApp.module('Entities', function(Entities, App, Backbone, Marionette, $, _) {
  Entities.Message = Backbone.Model.extend({
    defaults: {
      'username': '',
      'content': ''
    }
  });

  Entities.Messages = Backbone.Collection.extend({
    model: Entities.Message
  });

  Entities.User = Backbone.Model.extend({
  	defaults :{
  		'username': ''
  	}
  });

  Entities.Users = Backbone.Collection.extend({
  	model: Entities.User
  });
});