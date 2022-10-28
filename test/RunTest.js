#! /usr/bin/env node
var libSwigCNodejs = require('../swig/.libs/libSwigCNodejs');
let test = new libSwigCNodejs.Test;

test.setFn(
    (str)=>{console.log(str)}
);
test.callFn();
