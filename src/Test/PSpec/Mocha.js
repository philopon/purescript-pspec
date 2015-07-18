'use strict';

// module Test.PSpec.Mocha

exports.describeImpl = function (name, test){
  return function describeImplEff(){
    describe(name, function(){test(this)()});
    return {};
  }
}

exports.pendingImpl = function (e, mode, name){
  return function pendingImplEff(){
    if(mode === e.skip){
      it.skip(name);
    } else if(mode === e.only) {
      it.only(name);
    } else {
      it(name);
    }
    return {};
  }
}

exports.itImpl = function (e, mode, name, test){
  return function itImplEff(){
    if(mode === e.skip){
      it.skip(name, function(){test(this)()});
    } else if(mode === e.only) {
      it.only(name, function(){test(this)()});
    } else {
      it(name, function(){test(this)()});
    }
    return {};
  }
}

exports.beforeImpl = function (e, mode, name, hook){
  return function beforeImplEff(){
    if(name) before(name, function(){hook(this)()});
    else     before(function(){hook(this)()});
    return {};
  }
}

exports.afterImpl = function (e, mode, name, hook){
  return function afterImplEff(){
    if(name) after(name, function(){hook(this)()});
    else     after(function(){hook(this)()});
    return {};
  }
}

exports.beforeEachImpl = function (e, mode, name, hook){
  return function beforeEachImplEff(){
    if(name) beforeEach(name, function(){hook(this)()});
    else     beforeEach(function(){hook(this)()});
    return {};
  }
}

exports.afterEachImpl = function (e, mode, name, hook){
  return function afterEachImplEff(){
    if(name) afterEach(name, function(){hook(this)()});
    else     afterEach(function(){hook(this)()});
    return {};
  }
}

exports.itAsyncImpl = function (e, mode, name, test){
  return function itAsyncImplEff(){
    if(mode === e.skip){
      it.skip(name, function(done){test(this)(done)()});
    } else if(mode === e.only) {
      it.only(name, function(done){test(this)(done)()});
    } else {
      it(name, function(done){test(this)(done)()});
    }
    return {};
  }
}

exports.beforeAsyncImpl = function (e, mode, name, hook){
  return function beforeAsyncImplEff(){
    if(name) before(name, function(done){hook(this)(done)()});
    else     before(function(done){hook(this)(done)()});
    return {};
  }
}

exports.afterAsyncImpl = function (e, mode, name, hook){
  return function afterAsyncImplEff(){
    if(name) after(name, function(done){hook(this)(done)()});
    else     after(function(done){hook(this)(done)()});
    return {};
  }
}

exports.beforeEachAsyncImpl = function (e, mode, name, hook){
  return function beforeEachAsyncImplEff(){
    if(name) beforeEach(name, function(done){hook(this)(done)()});
    else     beforeEach(function(done){hook(this)(done)()});
    return {};
  }
}

exports.afterEachAsyncImpl = function (e, mode, name, hook){
  return function afterEachAsyncImplEff(){
    if(name) afterEach(name, function(done){hook(this)(done)()});
    else     afterEach(function(done){hook(this)(done)()});
    return {};
  }
}

exports.setTimeoutImpl = function (_this, to){
  return function setTimeoutImplEff(){
    _this.timeout(to);
    return {};
  }
}
