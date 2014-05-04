ChatApp.module('MessagingApp.UserList', function(UserList, App, Backbone, Marionette, $, _) {

  UserList.Controller = {
    showUserList: function() {
      var users = App.request('user:entities');
      var usersListView = new UserList.Users({collection: users});

      App.vent.on('newuser', function(data) {
        users.add({ username: data.username });
      });

      App.users.show(usersListView);
    }
  }

});
