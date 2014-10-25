Backbone.Wreqr = require 'backbone.wreqr'

# set global channel
Radio = Backbone.Wreqr.radio.channel 'global'

module.exports = Radio

