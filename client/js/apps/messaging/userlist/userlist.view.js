ChatApp.module('MessagingApp.UserList', function(UserList, App, Backbone, Marionette, $, _) {

  UserList.User = Marionette.ItemView.extend({
    template: '#userItem'
  });

  UserList.Users = Marionette.CollectionView.extend({
    itemView: UserList.User
  });
  
});