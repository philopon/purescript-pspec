purescript-pspec
===
test suite for purescript.

* [Module documentation](docs)
* [example](examples/Main.purs)

usage
---
1. write test code(see [example](examples/Main.purs)).
2. compile

    psc --main=Test.Main `ls bower_components/**/src/**/*.purs` `ls src/**/*.purs` examples/Main.purs > examples/main.js

3. execute mocha

    mocha examples/main.js
