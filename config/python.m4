#
# Autoconf macros for configuring the build of Python extension modules
#
# $PostgreSQL: pgsql/config/python.m4,v 1.10 2004/10/10 19:07:52 tgl Exp $
#

# PGAC_PATH_PYTHON
# ----------------
# Look for Python and set the output variable 'PYTHON'
# to 'python' if found, empty otherwise.
AC_DEFUN([PGAC_PATH_PYTHON],
[AC_PATH_PROG(PYTHON, python)
if test x"$PYTHON" = x""; then
  AC_MSG_ERROR([Python not found])
fi
])


# _PGAC_CHECK_PYTHON_DIRS
# -----------------------
# Determine the name of various directory of a given Python installation.
AC_DEFUN([_PGAC_CHECK_PYTHON_DIRS],
[AC_REQUIRE([PGAC_PATH_PYTHON])
AC_MSG_CHECKING([for Python distutils module])
if "${PYTHON}" 2>&- -c 'import distutils'
then
    AC_MSG_RESULT(yes)
else
    AC_MSG_RESULT(no)
    AC_MSG_ERROR([distutils module not found])
fi
AC_MSG_CHECKING([Python configuration directory])
python_version=`${PYTHON} -c "import sys; print sys.version[[:3]]"`
python_configdir=`${PYTHON} -c "from distutils.sysconfig import get_python_lib as f; import os; print os.path.join(f(plat_specific=1,standard_lib=1),'config')"`
python_includespec=`${PYTHON} -c "import distutils.sysconfig; print '-I'+distutils.sysconfig.get_python_inc()"`

AC_SUBST(python_version)[]dnl
AC_SUBST(python_configdir)[]dnl
AC_SUBST(python_includespec)[]dnl
# This should be enough of a message.
AC_MSG_RESULT([$python_configdir])
])# _PGAC_CHECK_PYTHON_DIRS


# PGAC_CHECK_PYTHON_EMBED_SETUP
# -----------------------------
AC_DEFUN([PGAC_CHECK_PYTHON_EMBED_SETUP],
[AC_REQUIRE([_PGAC_CHECK_PYTHON_DIRS])
AC_MSG_CHECKING([how to link an embedded Python application])

python_libspec=`${PYTHON} -c "import distutils.sysconfig,string; print '-lpython${python_version} '+string.join(filter(None,distutils.sysconfig.get_config_vars('LIBS','LIBC','LIBM','LOCALMODLIBS','BASEMODLIBS')))"`

AC_MSG_RESULT([${python_libspec}])

AC_SUBST(python_libspec)[]dnl
])# PGAC_CHECK_PYTHON_EMBED_SETUP
