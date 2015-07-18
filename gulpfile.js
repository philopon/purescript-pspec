var gulp       = require('gulp');
var purescript = require('gulp-purescript');
var merge      = require('merge-stream');
var mocha      = require('gulp-mocha');

var path       = require('path');

var sources =
    [ 'bower_components/purescript-*/src/**/*.purs'
    , 'src/**/*.purs'
    , 'examples/**/*.purs'
    ];

var ffis =
    [ 'bower_components/purescript-*/src/**/*.js'
    , 'src/**/*.js'
    ];

var modules = 
    [ 'Test.PSpec'
    , 'Test.PSpec.Types'
    , 'Test.PSpec.Mocha'
    ]

gulp.task('psc', function(){
  return purescript.psc({
    src: sources,
    ffi: ffis
    });
});

gulp.task('psci', function(){
  return purescript.psci({
    src: sources,
    ffi: ffis
    });
});

gulp.task('pscDocs', function(){
  return merge(modules.map(function(module){
    return purescript.pscDocs({
      src: sources,
      docgen: module
    }).pipe(gulp.dest('docs/' + module.replace(/\./g, '/') + '.md'));
  }));
});

gulp.task('example', ['psc'], function(){
  return merge()
  return purescript.pscBundle({
    src: 'output/**/*.js',
    main: 'Example1',
    module: 'Example1'
    }).pipe(gulp.dest('examples/Example1.js'))
    .pipe(mocha());
});

gulp.task('test', ['example']);

gulp.task('default', ['psc', 'psci', 'pscDocs', 'example']);
