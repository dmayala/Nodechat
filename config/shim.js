module.exports = {
  "jquery": "$",
  "underscore": "_",
  "bootstrap": { 
    "exports": "bootstrap",
    "depends": { 
      "jquery":"jQuery"
    }
  },
  "ripples-bootstrap": {
    "exports": "ripples",
    "depends": {
      'jquery': '$'
    }
  },
  "material-bootstrap": {
    "exports": "material",
	  "depends": { 
      "bootstrap":"bootstrap",
      "ripples-bootstrap": "ripples"
    }
  },
  "backbone": { 
    "exports": "Backbone",
    "depends": { 
      "jquery":"$",
      "underscore":"_"
    }
  },
  "backbone.localStorage": {
    "exports": "Backbone.LocalStorage",
    "depends": {
      "backbone":"Backbone"
    }
  },
  "backbone.syphon": {
    "exports": "Backbone.Syphon",
    "depends": {
      "jquery":"jQuery",
      "backbone":"Backbone"
    }
  },
  "backbone.picky": {
    "exports": "Backbone.Picky",
    "depends": {
      "backbone":"Backbone"
    }
  },
  "backbone.wreqr": {
    "exports": "Backbone.Wreqr",
    "depends": {
      "backbone":"Backbone"
    }
  },
  "backbone.marionette": {
    "exports": "Marionette",
    "depends": {
      "backbone":"Backbone",
      "backbone.wreqr":"Backbone.Wreqr"
    }
  }
}