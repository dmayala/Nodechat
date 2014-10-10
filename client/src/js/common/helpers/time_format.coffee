###
Handlebars.registerHelper('dateFormat', function(context, block) {
  if (window.moment) {
    var f = block.hash.format || "MMM DD, YYYY hh:mm:ss A";
    return moment(context).format(f); //had to remove Date(context)
  }else{
    return context;   //  moment plugin not available. return data as is.
  };
});

###

Handlebars = require 'hbsfy/runtime'
moment = require 'moment'

Handlebars.registerHelper 'timeFormat', (context, options) ->
  format = 'hh:mm:ss'
  moment(context).format(format)
