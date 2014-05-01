ChatApp.module('Views', function(Views, App, Backbone, Marionette, $, _) {

  Views.OutMessage = Marionette.ItemView.extend({
    template: '#outMessageTmp'
  });

  Views.OutboundMessages = Marionette.CollectionView.extend({
    itemView: Views.OutMessage
  });

  Views.UserItem = Marionette.ItemView.extend({
  	template: '#userItem'
  });

  Views.UserItemList = Marionette.CollectionView.extend({
  	itemView: Views.UserItem
  });

  Views.Socket = Marionette.ItemView.extend({

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