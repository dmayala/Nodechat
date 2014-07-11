module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    bowerInstall: {

      target: {
       src: [
        'client/*.html'   // .html support...
       ]
      }
    },

    browserify: {
      app: {
            options: {
                shim: {
                    jquery: {
                        path: 'client/js/vendor/jquery/dist/jquery.js',
                        exports: '$'
                    },
                    underscore: {
                        path: 'client/js/vendor/underscore/underscore.js',
                        exports: '_'
                    },
                    backbone: {
                        path: 'client/js/vendor/backbone/backbone.js',
                        exports: 'Backbone',
                        depends: {
                            underscore: 'underscore'
                        }
                    },
                    'backbone.babysitter': {
                        path: 'client/js/vendor/backbone.babysitter/lib/backbone.babysitter.js',
                        exports: 'Backbone.Babysitter',
                        depends: {
                            backbone: 'Backbone'
                        }
                    },
                    'backbone.wreqr': {
                        path: 'client/js/vendor/backbone.wreqr/lib/backbone.wreqr.js',
                        exports: 'Backbone.Wreqr',
                        depends: {
                            backbone: 'Backbone'
                        }
                    },
                    'backbone.marionette': {
                        path: 'client/js/vendor/marionette/lib/backbone.marionette.js',
                        exports: 'Marionette',
                        depends: {
                            jquery: '$',
                            backbone: 'Backbone',
                            underscore: '_'
                        }
                    }
                }
            },
            src: ['client/js/app.js'],
            dest: '_dist/js/built.js'
      }
    }
  });

  // Load Tasks
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-bower-install');
};