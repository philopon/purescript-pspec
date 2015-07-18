'use strict';

// module Test.PSpec

exports.itIs = function (done){
  return function itIsEff(){
    done();
  }
}

exports.itIsNotImpl = function (done, msg){
  return function itIsNotEff(){
    done(msg);
  }
}

exports.itIsNotPrimeImpl = function (done, msg){
  done(msg);
}
