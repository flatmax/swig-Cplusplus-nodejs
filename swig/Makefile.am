# Copyright (c) 2017 The Project Foundations Authors. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#    * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#    * Neither the name of mad chops coder AU nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

clean-local:
	-rm -rf build

nodejs_CPPFLAGS = $(NODE_CFLAGS) -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DBUILDING_NODE_EXTENSION
nodejs_CPPFLAGS += -O3  -ffunction-sections -fdata-sections -fno-omit-frame-pointer -fno-rtti -std=gnu++0x
nodejs_CPPFLAGS += -I$(top_srcdir)/include

nodejs_LDFLAGS = -version-info $(LT_CURRENT) -rpath=. -rdynamic -Bstatic -export-dynamic
nodejs_LDFLAGS +=

%_wrap.cxx: %.i
	$(SWIG_PATH)swig $(SWIG_INCLUDE_PATH) -I../include -c++ -javascript -node $<

BUILT_SOURCES =
CLEANFILES = Makefile.in

lib_LTLIBRARIES =

if HAVE_LIBNODE
lib_LTLIBRARIES += libSwigCNodejs.la
BUILT_SOURCES += swigCNodejs_wrap.cxx
CLEANFILES += swigCNodejs_wrap.cxx
swigCNodejs_wrap.cxx: ../include/Test.H
endif

libSwigCNodejs_la_SOURCES = swigCNodejs_wrap.cxx
libSwigCNodejs_la_CPPFLAGS =  $(nodejs_CPPFLAGS)
libSwigCNodejs_la_LDFLAGS = $(nodejs_LDFLAGS) $(top_builddir)/src/libSwigCNodejs.la

all: $(lib_LTLIBRARIES)
	if [ -e .libs/libSwigCNodejs.so ]; then cp -H .libs/libSwigCNodejs.so .libs/libSwigCNodejs.node; fi
