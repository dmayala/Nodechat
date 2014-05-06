ChatApp.module('MessagingApp.UserList', function(UserList, App, Backbone, Marionette, $, _) {

  UserList.User = Marionette.ItemView.extend({
  	tagName: 'tr',
    template: '#userItem'
  });

  UserList.Users = Marionette.CompositeView.extend({
  	tagName: 'table',
  	template: '#userListTemp',
    itemView: UserList.User,
    itemViewContainer: 'tbody',

    collectionEvents: {
    	'add': 'userNum',
    	'remove': 'userNum'
    },

    userNum: function() {
    	this.$('.js-usernum').html(this.collection.models.length);
    }
  });
  
});