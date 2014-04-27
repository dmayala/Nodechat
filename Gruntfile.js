module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    bowerInstall: {

    target: {
      src: [
        '*.html'   // .html support...
      ]
    }
  }
  });

  // Load Tasks
  grunt.loadNpmTasks('grunt-bower-install');
};
