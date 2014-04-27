ChatApp.module('Main', function(Main, App, Backbone, Marionette, $, _) {
  Main.Controller = Marionette.Controller.extend({

    initialize: function(options) {
      this.messages = new App.Entities.Messages();
      this.region = options.region;
      App.vent.on('serverMessage', function(content) {
        this.addMsg(content);
      }, this);
    },

    addMsg: function(content) {
      if (_.isObject(content)) {
        this.messages.add(content);
      }
    },

    show: function() {
      var view = new App.Views.OutboundMessages({collection: this.messages});
      this.region.show(view);
    }
  });

  Main.addInitializer(function() {
    new Main.Controller({region: App.msgOutput}).show();
  });
});
