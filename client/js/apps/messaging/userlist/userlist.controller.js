ChatApp.module('MessagingApp.UserList', function(UserList, App, Backbone, Marionette, $, _) {

  UserList.Controller = {
    showUserList: function() {
      var users = App.request('user:entities');
      var usersListView = new UserList.Users({collection: users});

      App.vent.on('newuser', function(data) {
        users.add(data);
      });

      App.vent.on('userquit', function (data) {
        users.remove(data.id);
      });

      App.users.show(usersListView);
    }
  }

});
