(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var ChatApp = new Marionette.Application();

ChatApp.addRegions({
  'msgPanel': '#msgPanel',
  'users': '#users'
});

ChatApp.navigate = function(route,  options){
  options || (options = {});
  Backbone.history.navigate(route, options);
};

ChatApp.getCurrentRoute = function(){
  return Backbone.history.fragment
};

ChatApp.on('initialize:after', function(){
  if(Backbone.history){
    Backbone.history.start();

    if(this.getCurrentRoute() == ''){
      this.trigger('chat:show');
    }
  }
});

module.exports = ChatApp;
},{}],2:[function(require,module,exports){
var App = require('../../app')

console.log(App);

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

},{"../../app":1}]},{},[2])