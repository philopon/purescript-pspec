purescript-pspec
===
[![Bower version](https://badge.fury.io/bo/purescript-pspec.svg)](http://badge.fury.io/bo/purescript-pspec)
[![devDependency Status](https://david-dm.org/philopon/purescript-pspec/dev-status.svg)](https://david-dm.org/philopon/purescript-pspec#info=devDependencies)

test suite for purescript.

* [Module documentation](docs)
* [example](examples/Main.purs)

usage
---
1. write test code(see [example](examples/Main.purs)).
2. compile

    ```.sh
    $ psc --main=Test.Main `ls bower_components/**/src/**/*.purs` `ls src/**/*.purs` examples/Main.purs > examples/main.js
    ```

3. execute mocha

    ```.sh
    $ mocha examples/main.js
    ```
