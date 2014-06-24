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
      
      users.fetch({success: 
      function() {
        var filterType = _.filter(users.models, function(item) {
          return item.get('username') !== '';
        });
        users.reset(filterType);
        }
      });

      return users;
    }
  };

  App.reqres.setHandler('user:entities', function() {
    return API.getUserEntities();
  });
  
});