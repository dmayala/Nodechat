ChatApp.module('Main', function(Main, App, Backbone, Marionette, $, _) {
  Main.Controller = Marionette.Controller.extend({

    initialize: function(options) {
      this.messages = new App.Entities.Messages();
      this.users = new App.Entities.Users();
      App.vent.on('serverMessage', this.addMsg, this);
      App.vent.on('newuser', this.addUser, this);
    },

    addMsg: function(content) {
      if (_.isObject(content)) {
        this.messages.add(content);
      }
    },

    addUser: function(user) {
      this.users.add(user);
    },

    show: function() {
      var outboundView = new App.Views.OutboundMessages({collection: this.messages});
      var userListView = new App.Views.UserItemList({collection: this.users});
      App.msgOutput.show(outboundView);
      App.users.show(userListView);
    }
  });

  Main.addInitializer(function() {
    new Main.Controller().show();
  });
});
