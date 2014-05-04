ChatApp.module('MessagingApp.Panel', function(Panel, App, Backbone, Marionette, $, _) {
  Panel.Controller = {

    showPanel: function() {
      var messages = App.request('message:entities');
      var messagesLayout = new Panel.Layout();
      var messagesOutput = new Panel.Messages({ collection: messages });
      var messagesInput = new Panel.MessageInput();

      messagesLayout.on('show', function() {
        messagesLayout.msgOutRegion.show(messagesOutput);
        messagesLayout.msgInRegion.show(messagesInput);
      });  

      App.vent.on('serverMessage', function(data) {
        messages.add({username: data.username, content: data.content });
      });

      App.msgPanel.show(messagesLayout);
    }
  }
});