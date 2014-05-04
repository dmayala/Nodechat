ChatApp.module('Entities', function(Entities, App, Backbone, Marionette, $, _) {

  Entities.User = Backbone.Model.extend({
    defaults :{
      urlRoot: 'users',
      username: ''
    }
  });

  Entities.Users = Backbone.Collection.extend({
    url: 'users',
    model: Entities.User
  });

  var API = {
    getUserEntities: function() {
      var users = new Entities.Users();
      users.fetch();
      return users;
    }
  };

  App.reqres.setHandler('user:entities', function() {
    return API.getUserEntities();
  });
  
});