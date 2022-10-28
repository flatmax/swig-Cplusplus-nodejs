// Copyright (c) 2017 The Project Foundations Authors. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//    * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//    * Neither the name of mad chops coder AU nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

%module "swigCNodejs"
%{
#include "Test.H"
%}

%include "std_string.i"
%include "Test.H"

%extend Test {

  void setCallback(const std::string& fnName){
    SWIGV8_HANDLESCOPE();

    v8::Isolate* isolate = v8::Isolate::GetCurrent();

    v8::Local<v8::Value> fnObj = SWIGV8_CURRENT_CONTEXT()->Global()->Get(SWIGV8_CURRENT_CONTEXT(), v8::String::NewFromUtf8(isolate, fnName.c_str())).ToLocalChecked();

    if (!fnObj->IsFunction()){
      printf("setupCallback : error no function found\n");
      return;
    } else
      printf("setupCallback : %s function found\n", fnName.c_str());

    v8::Local<v8::Function> func = v8::Local<v8::Function>::Cast(fnObj);
    theFunction.Reset(isolate, func);

    func = v8::Local<v8::Function>::New(isolate, theFunction);
    if (!func.IsEmpty()) {
      const unsigned argc = 1;
      v8::Local<v8::Value> argv[argc] = { v8::String::NewFromUtf8(isolate, "hello world") };
      func->Call(SWIGV8_CURRENT_CONTEXT(), func, argc, argv);
     }
  }
}
