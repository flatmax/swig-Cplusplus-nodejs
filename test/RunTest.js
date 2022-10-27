#! /usr/bin/env node
var libSwigCNodejs = require('../swig/.libs/libSwigCNodejs');
let test = new libSwigCNodejs.Test;

global.fnName = function (str) {
  console.log(str);
}

test.setCallback("fnName");
