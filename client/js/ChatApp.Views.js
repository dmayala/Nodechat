ChatApp.module('Views', function(Views, App, Backbone, Marionette, $, _) {

  Views.OutMessage = Marionette.ItemView.extend({
    template: '#outMessageTmp'
  });

  Views.OutboundMessages = Marionette.CollectionView.extend({
    itemView: Views.OutMessage
  });
});