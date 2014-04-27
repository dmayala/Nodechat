module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    bowerInstall: {

    target: {
      src: [
        'client/*.html'   // .html support...
      ]
    }
  }
  });

  // Load Tasks
  grunt.loadNpmTasks('grunt-bower-install');
};
