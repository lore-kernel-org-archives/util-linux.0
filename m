Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753456AbdBJU67 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 10 Feb 2017 15:58:59 -0500
Subject: [PATCH 0/3] hwclock: remove date(1)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
Date: Fri, 10 Feb 2017 15:58:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


This branch adds the parse_datetime module from the gnu
portability library. With the following improvements to hwclock:

* Prevent shell injection vulnerabilities from popen() date(1).

* Remove the system dependency on date(1).

* Significant cleanup of hwclock.c code.

* Bug fix for the --predict function

For a parse_datetime2() demonstration this command works well:

./hwclock --predict --date 'next month' -D


Tested with 'make check':
---------------------------------------------------------------------
  All 191 tests PASSED
---------------------------------------------------------------------


The following changes since commit 7ccc1643abdd0cb9780ca0304dfdcbc4c5b11eae:

  findmnt: use line separator for --poll output (2017-02-10 17:28:07 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git gnulib3

for you to fetch changes up to b61e954ec899bd656f7c12d9f93f7f7ef3f0d704:

  hwclock: use gnulib's parse_datetime2 function (2017-02-10 14:55:48 -0500)

----------------------------------------------------------------
J William Piggott (3):
  gnulib: add source for gnulib parse-datetime mod
  build-sys: configure gnulib parse-datetime module
  hwclock: use gnulib's parse_datetime2 function

 Makefile.am                     |   10 +-
 autogen.sh                      |    2 +-
 config/snippet/_Noreturn.h      |   10 +
 config/snippet/arg-nonnull.h    |   26 +
 config/snippet/c++defs.h        |  316 +++++
 config/snippet/warn-on-use.h    |  109 ++
 configure.ac                    |    6 +-
 gllib/Makefile.am               | 1201 +++++++++++++++++++
 gllib/alloca.in.h               |   65 ++
 gllib/basename-lgpl.c           |   75 ++
 gllib/c-ctype.c                 |    3 +
 gllib/c-ctype.h                 |  366 ++++++
 gllib/dirname-lgpl.c            |   86 ++
 gllib/dirname.h                 |   54 +
 gllib/dosname.h                 |   53 +
 gllib/errno.in.h                |  279 +++++
 gllib/error.c                   |  406 +++++++
 gllib/error.h                   |   75 ++
 gllib/exitfail.c                |   24 +
 gllib/exitfail.h                |   18 +
 gllib/flexmember.h              |   42 +
 gllib/getprogname.c             |  185 +++
 gllib/getprogname.h             |   40 +
 gllib/gettext.h                 |  292 +++++
 gllib/gettime.c                 |   48 +
 gllib/gettimeofday.c            |  154 +++
 gllib/gldoc/parse-datetime.texi |  594 ++++++++++
 gllib/intprops.h                |  458 ++++++++
 gllib/limits.in.h               |   63 +
 gllib/malloc.c                  |   56 +
 gllib/malloca.c                 |  149 +++
 gllib/malloca.h                 |  128 ++
 gllib/malloca.valgrind          |    7 +
 gllib/mktime-internal.h         |   37 +
 gllib/mktime.c                  |  630 ++++++++++
 gllib/msvc-inval.c              |  129 +++
 gllib/msvc-inval.h              |  222 ++++
 gllib/msvc-nothrow.c            |   49 +
 gllib/msvc-nothrow.h            |   43 +
 gllib/parse-datetime.h          |   29 +
 gllib/parse-datetime.y          | 2440 +++++++++++++++++++++++++++++++++++++++
 gllib/setenv.c                  |  390 +++++++
 gllib/stdbool.in.h              |  132 +++
 gllib/stddef.in.h               |  110 ++
 gllib/stdint.in.h               |  707 ++++++++++++
 gllib/stdio.in.h                | 1377 ++++++++++++++++++++++
 gllib/stdlib.in.h               |  992 ++++++++++++++++
 gllib/strerror-override.c       |  302 +++++
 gllib/strerror-override.h       |   56 +
 gllib/strerror.c                |   71 ++
 gllib/strftime.c                | 1499 ++++++++++++++++++++++++
 gllib/strftime.h                |   33 +
 gllib/string.in.h               | 1046 +++++++++++++++++
 gllib/stripslash.c              |   45 +
 gllib/sys_time.in.h             |  220 ++++
 gllib/sys_types.in.h            |   53 +
 gllib/time-internal.h           |   49 +
 gllib/time.in.h                 |  297 +++++
 gllib/time_r.c                  |   44 +
 gllib/time_rz.c                 |  322 ++++++
 gllib/timegm.c                  |   40 +
 gllib/timespec.c                |    3 +
 gllib/timespec.h                |  112 ++
 gllib/unistd.c                  |    4 +
 gllib/unistd.in.h               | 1590 +++++++++++++++++++++++++
 gllib/unsetenv.c                |  127 ++
 gllib/verify.h                  |  279 +++++
 gllib/xalloc-die.c              |   41 +
 gllib/xalloc-oversized.h        |   60 +
 gllib/xalloc.h                  |  266 +++++
 gllib/xmalloc.c                 |  122 ++
 glm4/00gnulib.m4                |   46 +
 glm4/absolute-header.m4         |  102 ++
 glm4/alloca.m4                  |  121 ++
 glm4/bison.m4                   |   24 +
 glm4/clock_time.m4              |   31 +
 glm4/dirname.m4                 |   19 +
 glm4/double-slash-root.m4       |   38 +
 glm4/eealloc.m4                 |   31 +
 glm4/environ.m4                 |   47 +
 glm4/errno_h.m4                 |  137 +++
 glm4/error.m4                   |   27 +
 glm4/extensions.m4              |  173 +++
 glm4/extern-inline.m4           |  102 ++
 glm4/flexmember.m4              |   43 +
 glm4/getprogname.m4             |   43 +
 glm4/gettime.m4                 |   13 +
 glm4/gettimeofday.m4            |  138 +++
 glm4/gnulib-cache.m4            |   49 +
 glm4/gnulib-common.m4           |  462 ++++++++
 glm4/gnulib-comp.m4             |  485 ++++++++
 glm4/gnulib-tool.m4             |   57 +
 glm4/include_next.m4            |  223 ++++
 glm4/limits-h.m4                |   31 +
 glm4/longlong.m4                |  113 ++
 glm4/malloc.m4                  |  101 ++
 glm4/malloca.m4                 |   15 +
 glm4/mktime.m4                  |  268 +++++
 glm4/msvc-inval.m4              |   19 +
 glm4/msvc-nothrow.m4            |   10 +
 glm4/multiarch.m4               |   62 +
 glm4/off_t.m4                   |   18 +
 glm4/parse-datetime.m4          |   55 +
 glm4/setenv.m4                  |  160 +++
 glm4/ssize_t.m4                 |   23 +
 glm4/stdbool.m4                 |  108 ++
 glm4/stddef_h.m4                |   51 +
 glm4/stdint.m4                  |  541 +++++++++
 glm4/stdio_h.m4                 |  225 ++++
 glm4/stdlib_h.m4                |  120 ++
 glm4/strerror.m4                |   96 ++
 glm4/strftime.m4                |   28 +
 glm4/string_h.m4                |  120 ++
 glm4/sys_socket_h.m4            |  176 +++
 glm4/sys_time_h.m4              |  111 ++
 glm4/sys_types_h.m4             |   49 +
 glm4/time_h.m4                  |  134 +++
 glm4/time_r.m4                  |   58 +
 glm4/time_rz.m4                 |   21 +
 glm4/timegm.m4                  |   26 +
 glm4/timespec.m4                |   11 +
 glm4/tm_gmtoff.m4               |   14 +
 glm4/unistd_h.m4                |  190 +++
 glm4/warn-on-use.m4             |   47 +
 glm4/wchar_t.m4                 |   24 +
 glm4/wint_t.m4                  |   62 +
 glm4/xalloc.m4                  |    7 +
 sys-utils/Makemodule.am         |    3 +-
 sys-utils/hwclock.c             |  105 +-
 129 files changed, 24876 insertions(+), 105 deletions(-)
 create mode 100644 config/snippet/_Noreturn.h
 create mode 100644 config/snippet/arg-nonnull.h
 create mode 100644 config/snippet/c++defs.h
 create mode 100644 config/snippet/warn-on-use.h
 create mode 100644 gllib/Makefile.am
 create mode 100644 gllib/alloca.in.h
 create mode 100644 gllib/basename-lgpl.c
 create mode 100644 gllib/c-ctype.c
 create mode 100644 gllib/c-ctype.h
 create mode 100644 gllib/dirname-lgpl.c
 create mode 100644 gllib/dirname.h
 create mode 100644 gllib/dosname.h
 create mode 100644 gllib/errno.in.h
 create mode 100644 gllib/error.c
 create mode 100644 gllib/error.h
 create mode 100644 gllib/exitfail.c
 create mode 100644 gllib/exitfail.h
 create mode 100644 gllib/flexmember.h
 create mode 100644 gllib/getprogname.c
 create mode 100644 gllib/getprogname.h
 create mode 100644 gllib/gettext.h
 create mode 100644 gllib/gettime.c
 create mode 100644 gllib/gettimeofday.c
 create mode 100644 gllib/gldoc/parse-datetime.texi
 create mode 100644 gllib/intprops.h
 create mode 100644 gllib/limits.in.h
 create mode 100644 gllib/malloc.c
 create mode 100644 gllib/malloca.c
 create mode 100644 gllib/malloca.h
 create mode 100644 gllib/malloca.valgrind
 create mode 100644 gllib/mktime-internal.h
 create mode 100644 gllib/mktime.c
 create mode 100644 gllib/msvc-inval.c
 create mode 100644 gllib/msvc-inval.h
 create mode 100644 gllib/msvc-nothrow.c
 create mode 100644 gllib/msvc-nothrow.h
 create mode 100644 gllib/parse-datetime.h
 create mode 100644 gllib/parse-datetime.y
 create mode 100644 gllib/setenv.c
 create mode 100644 gllib/stdbool.in.h
 create mode 100644 gllib/stddef.in.h
 create mode 100644 gllib/stdint.in.h
 create mode 100644 gllib/stdio.in.h
 create mode 100644 gllib/stdlib.in.h
 create mode 100644 gllib/strerror-override.c
 create mode 100644 gllib/strerror-override.h
 create mode 100644 gllib/strerror.c
 create mode 100644 gllib/strftime.c
 create mode 100644 gllib/strftime.h
 create mode 100644 gllib/string.in.h
 create mode 100644 gllib/stripslash.c
 create mode 100644 gllib/sys_time.in.h
 create mode 100644 gllib/sys_types.in.h
 create mode 100644 gllib/time-internal.h
 create mode 100644 gllib/time.in.h
 create mode 100644 gllib/time_r.c
 create mode 100644 gllib/time_rz.c
 create mode 100644 gllib/timegm.c
 create mode 100644 gllib/timespec.c
 create mode 100644 gllib/timespec.h
 create mode 100644 gllib/unistd.c
 create mode 100644 gllib/unistd.in.h
 create mode 100644 gllib/unsetenv.c
 create mode 100644 gllib/verify.h
 create mode 100644 gllib/xalloc-die.c
 create mode 100644 gllib/xalloc-oversized.h
 create mode 100644 gllib/xalloc.h
 create mode 100644 gllib/xmalloc.c
 create mode 100644 glm4/00gnulib.m4
 create mode 100644 glm4/absolute-header.m4
 create mode 100644 glm4/alloca.m4
 create mode 100644 glm4/bison.m4
 create mode 100644 glm4/clock_time.m4
 create mode 100644 glm4/dirname.m4
 create mode 100644 glm4/double-slash-root.m4
 create mode 100644 glm4/eealloc.m4
 create mode 100644 glm4/environ.m4
 create mode 100644 glm4/errno_h.m4
 create mode 100644 glm4/error.m4
 create mode 100644 glm4/extensions.m4
 create mode 100644 glm4/extern-inline.m4
 create mode 100644 glm4/flexmember.m4
 create mode 100644 glm4/getprogname.m4
 create mode 100644 glm4/gettime.m4
 create mode 100644 glm4/gettimeofday.m4
 create mode 100644 glm4/gnulib-cache.m4
 create mode 100644 glm4/gnulib-common.m4
 create mode 100644 glm4/gnulib-comp.m4
 create mode 100644 glm4/gnulib-tool.m4
 create mode 100644 glm4/include_next.m4
 create mode 100644 glm4/limits-h.m4
 create mode 100644 glm4/longlong.m4
 create mode 100644 glm4/malloc.m4
 create mode 100644 glm4/malloca.m4
 create mode 100644 glm4/mktime.m4
 create mode 100644 glm4/msvc-inval.m4
 create mode 100644 glm4/msvc-nothrow.m4
 create mode 100644 glm4/multiarch.m4
 create mode 100644 glm4/off_t.m4
 create mode 100644 glm4/parse-datetime.m4
 create mode 100644 glm4/setenv.m4
 create mode 100644 glm4/ssize_t.m4
 create mode 100644 glm4/stdbool.m4
 create mode 100644 glm4/stddef_h.m4
 create mode 100644 glm4/stdint.m4
 create mode 100644 glm4/stdio_h.m4
 create mode 100644 glm4/stdlib_h.m4
 create mode 100644 glm4/strerror.m4
 create mode 100644 glm4/strftime.m4
 create mode 100644 glm4/string_h.m4
 create mode 100644 glm4/sys_socket_h.m4
 create mode 100644 glm4/sys_time_h.m4
 create mode 100644 glm4/sys_types_h.m4
 create mode 100644 glm4/time_h.m4
 create mode 100644 glm4/time_r.m4
 create mode 100644 glm4/time_rz.m4
 create mode 100644 glm4/timegm.m4
 create mode 100644 glm4/timespec.m4
 create mode 100644 glm4/tm_gmtoff.m4
 create mode 100644 glm4/unistd_h.m4
 create mode 100644 glm4/warn-on-use.m4
 create mode 100644 glm4/wchar_t.m4
 create mode 100644 glm4/wint_t.m4
 create mode 100644 glm4/xalloc.m4

