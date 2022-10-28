#!/usr/bin/env bash

# remove original swig generate functions as we are replacing them with our own
sed -i '/^static SwigV8ReturnValue _wrap_Test_setFn.*{$/,/^\}/d' $1
sed -i '/^static SwigV8ReturnValue _wrap_Test_callFn.*{$/,/^\}/d' $1
