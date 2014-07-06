var Marionette = require('backbone.marionette');
var App = require('../../app');

ChatApp.module('MessagingApp', function(MessagingApp, App, Backbone, Marionette, $, _) {

  MessagingApp.Router = Marionette.AppRouter.extend({
    appRoutes: {
      'chat': 'showMessaging'
    }
  });

  var API = {
    showMessaging: function() {
      MessagingApp.Panel.Controller.showPanel();
      MessagingApp.UserList.Controller.showUserList();
    }
  };

  App.on('chat:show', function(){
    App.navigate('chat');
    API.showMessaging();
  });

  App.addInitializer(function() {
    new MessagingApp.Router({
      controller: API
    });
  });

});
