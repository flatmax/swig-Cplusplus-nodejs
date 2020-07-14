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

m4_define([project_current_version], [0]) # ++ if API added (age++), removed, or changed (age=0)
m4_define([project_revision_version], [0]) # ++ if API same but src code change
m4_define([project_age_version], [0]) # ++ if API added since last release, if API removed or changed then age=0
m4_define([project_version], [project_current_version.project_revision_version.project_age_version])

AC_INIT( swig_C++_nodejs, [swig_C++_nodejs_version], [ https://github.com/madChopsCoderAu/Project Foundations/issues ])
AM_INIT_AUTOMAKE
AC_CONFIG_SRCDIR([include/Test.H])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_PREFIX_DEFAULT(/usr)

LT_INIT
AC_SUBST(LT_RELEASE, [project_version])
AC_SUBST(LT_CURRENT, [project_current_version:project_revision_version:project_age_version])

AC_PROG_CXX

# doxygen support
AC_ARG_ENABLE(doc, AS_HELP_STRING([--disable-doc],
        [Disable API documentation generation (default: auto)]),
        [DOC=$enableval], [DOC=auto])
if test "x$DOC" = xauto ; then
AC_CHECK_PROGS([DOXYGEN], [doxygen])
if test -z "$DOXYGEN";
   then AC_MSG_WARN([Doxygen not found - continuing without Doxygen support])
fi
fi
# Checks for documentation
AM_CONDITIONAL([HAVE_DOXYGEN],[test -n "$DOXYGEN"])
AM_COND_IF([HAVE_DOXYGEN], [AC_CONFIG_FILES([api/Doxyfile])])

# check for emscripten compilation
m4_ifdef([AM_EMSCRIPTEN], [AM_EMSCRIPTEN])
AM_CONDITIONAL(HAVE_EMSCRIPTEN, test x$emscripten_compiler = xyes)
if test "x$emscripten_compiler" = xyes; then
AC_SUBST([AM_CXXFLAGS], ["-s DEMANGLE_SUPPORT=1 -std=c++11 -O3 -fno-exceptions -s NO_EXIT_RUNTIME=1 "])
AC_DEFINE(HAVE_EMSCRIPTEN, [], [whether building for emsdk])
fi

AC_CHECK_LIB(node, atexit, HAVE_LIBNODE="yes", HAVE_LIBNODE="no")
AM_CONDITIONAL(HAVE_LIBNODE, test x$HAVE_LIBNODE = xyes)
if test "x$HAVE_LIBNODE" == xyes ; then
    AC_DEFINE(HAVE_LIBNODE, [], [whether to build in libnode support])
fi

AC_ARG_WITH([node-include-path],
[--with-node-include-path location of the nodejs headers, defaults to /usr/local/nodejs6/include/node],
[NODE_CFLAGS="-I$withval"],
[NODE_CFLAGS='-I/usr/include/nodejs/src -I/usr/include/nodejs/deps/v8/include'])
AC_SUBST(NODE_CFLAGS)

AC_ARG_WITH([swig-path],
[--with-swig-path location of the swig cmd, defaults to ""],
[SWIG_PATH="$withval"],
[SWIG_PATH=""])
AC_SUBST(SWIG_PATH)

AC_ARG_WITH([swig-include-path],
[--with-swig-include-path location of the include directories, defaults to ],
[SWIG_INCLUDE_PATH="$withval"],
[SWIG_INCLUDE_PATH="-I/usr/include"])
AC_SUBST(SWIG_INCLUDE_PATH)

AC_C_INLINE
AC_FUNC_ERROR_AT_LINE

AC_CONFIG_FILES([Makefile src/Makefile swig/Makefile api/Makefile test/Makefile])
AC_OUTPUT
