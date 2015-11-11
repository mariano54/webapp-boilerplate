module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-newer'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffee-react'
  grunt.loadNpmTasks 'grunt-coffee-jshint'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-coffeelint-cjsx'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-karma'


  grunt.registerTask 'default', ['compile', 'browserify:dev', 'watch']
  grunt.registerTask 'production', ['compile', 'browserify:prod', 'uglify']

  grunt.registerTask 'compile', ['clean',  'concurrent:hint',
                                 'concurrent:compile', 'copy']


  moveToPublic = (srcExt, dstExt) ->
    (dst, src) ->
      destName = src.replace "#{srcExt}", dstExt
      if src.indexOf('public') > -1 then return destName
      destName = destName.replace /src/, 'public'
      return destName

  b =
    dev:
      files:
        'public/bundle.js' : ['public/index.js']
        'test/public/bundle.js' : ['test/public/**/*']
      options:
        watch: true
        keepAlive: false
        exclude: '**/bundle.js'
        transform: ['require-globify']
    prod:
      files:
        'public/bundle.js' : ['public/index.js']
      options:
        watch: false
        keepAlive: false
        exclude: '**/bundle.js'
        transform: ['require-globify']


  gruntConfig =
    karma:
      unit:
        configFile: 'test/testConfig.coffee'
    pkg:
      grunt.file.readJSON 'package.json'
    browserify: b
    clean:
      public: ['public/**/*', 'test/public/**/*']

    coffee:
      compile:
        expand: true
        src: ['**/*.coffee', '!node_modules/{*,**}', '!gruntFile.coffee',
              '!.git/**/*', '!test/testConfig.coffee']
        rename: moveToPublic '.coffee', '.js'
    cjsx:
      compile:
        expand: true
        src: ['**/*.cjsx', '!node_modules/{*,**}']
        rename: moveToPublic '.cjsx', '.js'
    coffeelint:
      compile:
        src: ['**/*.cjsx', '!node_modules/{*,**}', '!.git/**/*']
        options:
          'max_line_length':
            'level': 'ignore'
    coffee_jshint:
      options:
        jshintOptions: [ 'browser', 'jquery', '-W058', '-W056']
        globals: ['require', 'console', 'module', 'document', 'angular',
                  '__dirname', 'process', 'it', 'describe', 'before',
                  'beforeAll', 'after', 'afterAll']
      compile:
        src: ['**/*.coffee', '!node_modules/{*,**}', '!Gruntfile.coffee',
              '!.git/**/*']
    uglify:
      my_target:
        files:
          'public/bundle.js': ['public/bundle.js']
    copy:
      main:
        src: 'src/**/index.html'
        dest: 'public/index.html'
      proxy:
        src: 'src/**/proxy.html'
        dest: 'public/proxy.html'

    watch:
      coffeescript:
        files: ['**/*.coffee', '!node_modules/{*,**}' , '!.git/{*,**}',
                '!gruntFile.coffee']
        tasks: ['newer:coffee_jshint', 'newer:coffee', ]
      cjsx:
        files: ['**/*.cjsx', '!node_modules/{*,**}' , '!.git/{*,**}',
                '!gruntFile.coffee']
        tasks: ['newer:coffeelint', 'newer:cjsx']
      html:
        files: ['src/**/*.html', '!node_modules/{*,**}' , '!.git/{*,**}']
        tasks: ['copy']
      options:
        livereload: true
    concurrent:
      hint:
        tasks: ['coffeelint', 'coffee_jshint']
        options:
          logConcurrentOutput: true
      compile:
        tasks: ['cjsx' , 'coffee']
        options:
          logConcurrentOutput: true

  require('time-grunt')(grunt)
  grunt.initConfig gruntConfig
