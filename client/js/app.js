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
      ChatApp.trigger('chat:show');
    }
  }
});