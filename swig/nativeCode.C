// NOTE : ending the following line with a "{" will break the sed command to strip the original function from the _wrap.cxx file
static SwigV8ReturnValue _wrap_Test_setFn(const SwigV8Arguments &args) {SWIGV8_HANDLESCOPE();
   SWIGV8_VALUE jsresult;
v8::Isolate* isolate = v8::Isolate::GetCurrent();
v8::TryCatch try_catch(isolate);

if (args[0]->IsFunction()) {
  printf("function found\n");
       v8::Local<v8::Function> func = v8::Local<v8::Function>::Cast(args[0]);
       v8::Function * ptr = *func;
       theFunction.Reset(isolate, func);
   }
   else {
     printf("no function found\n");
       theFunction.Reset();
   }

  jsresult = SWIGV8_UNDEFINED();
  SWIGV8_RETURN(jsresult);

  goto fail;
fail:
  SWIGV8_RETURN(SWIGV8_UNDEFINED());
}

// NOTE : ending the following line with a "{" will break the sed command to strip the original function from the _wrap.cxx file
static SwigV8ReturnValue _wrap_Test_callFn(const SwigV8Arguments &args){SWIGV8_HANDLESCOPE();
  SWIGV8_VALUE jsresult;
  v8::Isolate* isolate = v8::Isolate::GetCurrent();
  v8::TryCatch try_catch(isolate);
  if(!theFunction.IsEmpty()) {
   v8::Local<v8::Function> func = v8::Local<v8::Function>::New(isolate, theFunction);

   if (!func.IsEmpty()) {
       const unsigned argc = 1;
       v8::Local<v8::Value> argv[argc] =
           { v8::String::NewFromUtf8(isolate, "hello world") };
      v8::Local<v8::Value> ret;

       func->Call(SWIGV8_CURRENT_CONTEXT(), func,  argc, argv);
   }
 }
 jsresult = SWIGV8_UNDEFINED();

 SWIGV8_RETURN(jsresult);
 goto fail;
fail:
 SWIGV8_RETURN(SWIGV8_UNDEFINED());
}
