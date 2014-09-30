ChatApp.module('MessagingApp.Panel', function(Panel, App, Backbone, Marionette, $, _) {

  Panel.Layout = Marionette.Layout.extend({
    template: '#msgPanelTmp',

    regions: {
      msgInRegion: '#msgIn',
      msgOutRegion: '#msgOut'
    }
  });

  Panel.Message = Marionette.ItemView.extend({
    template: '#outMessageTmp'
  });

  Panel.Messages = Marionette.CollectionView.extend({
    itemView: Panel.Message,
  });

  Panel.MessageInput = Marionette.ItemView.extend({

    template: '#msgInOptions',

    events: {
      'keydown #input': 'checkInput'
    },

    checkInput: function(keyboardEvent) {
      if (keyboardEvent.keyCode === 13) {
        this.sendMessage(this.$('#input').val());
        this.$('#input').val('');
        return false;
      } else {
        return true;
      }
    },

    sendMessage: function (message) {
      var commandMatch = message.match(/^\/(\w*)(.*)/);
      if (commandMatch) {
        this.sendCommand(commandMatch[1], commandMatch[2].trim());
      } else {
        App.vent.trigger('clientMessage', message);
      }
    },

    sendCommand: function (command, args) {
      if (command === 'j') {
        App.vent.trigger('join', args);
      } else {
        alert('unknown command: ' + command);
      }
    }

  });
});