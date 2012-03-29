Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50609 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758691Ab2C2Qpl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:41 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BC3258FB75
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:39 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/20] uuidd: implement --socket-activation option
Date: Thu, 29 Mar 2012 18:45:15 +0200
Message-Id: <1333039528-24784-8-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Implement --socket-activatoin option, which is supposed to be used
with systemd (or equivalent init system) socket activation mechanism.
With this option, the UUID daemon does not create the socket on its own,
but instead expect the connection fd to be provided by the calling
process.

This option is only available if util-linux is configured with
--enable-uuidd-socket-activation option. With this configure
option, the uuidd is compiled with sd-daemon.c.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 configure.ac           |   12 +
 misc-utils/Makefile.am |    6 +
 misc-utils/sd-daemon.c |  530 ++++++++++++++++++++++++++++++++++++++++++++++++
 misc-utils/sd-daemon.h |  282 +++++++++++++++++++++++++
 misc-utils/uuidd.8     |    6 +
 misc-utils/uuidd.c     |   89 ++++++--
 6 files changed, 903 insertions(+), 22 deletions(-)
 create mode 100644 misc-utils/sd-daemon.c
 create mode 100644 misc-utils/sd-daemon.h

diff --git a/configure.ac b/configure.ac
index 2140bc5..bb56948 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1101,6 +1101,18 @@ if test "x$enable_login_chown_vcs" = xyes; then
 fi
 
 
+AC_ARG_ENABLE([uuidd-socket-activation],
+  AS_HELP_STRING([--enable-uuidd-socket-activation], [build uuidd with support for systemd socket activation]),
+  [], enable_uuidd_socket_activation=no
+)
+
+AM_CONDITIONAL(UUIDD_SOCKET_ACTIVATION, test "x$enable_uuidd_socket_activation" = xyes)
+
+if test "x$enable_uuidd_socket_activation" = xyes; then
+  AC_DEFINE(UUIDD_SOCKET_ACTIVATION, 1, [Should uuidd support socket activation?])
+fi
+
+
 AC_ARG_ENABLE([login-stat-mail],
   AS_HELP_STRING([--enable-login-stat-mail], [let login stat() the mailbox]),
   [], enable_login_stat_mail=no
diff --git a/misc-utils/Makefile.am b/misc-utils/Makefile.am
index acf2c9d..5db5183 100644
--- a/misc-utils/Makefile.am
+++ b/misc-utils/Makefile.am
@@ -79,6 +79,12 @@ usrsbin_exec_PROGRAMS += uuidd
 dist_man_MANS += uuidd.8
 uuidd_LDADD = $(ul_libuuid_la)
 uuidd_CFLAGS = $(AM_CFLAGS) -I$(ul_libuuid_srcdir)
+uuidd_SOURCES = \
+	uuidd.c
+if UUIDD_SOCKET_ACTIVATION
+uuidd_SOURCES += sd-daemon.c
+uuidd_LDADD += -lrt
+endif
 endif
 
 if BUILD_LIBBLKID
diff --git a/misc-utils/sd-daemon.c b/misc-utils/sd-daemon.c
new file mode 100644
index 0000000..763e079
--- /dev/null
+++ b/misc-utils/sd-daemon.c
@@ -0,0 +1,530 @@
+/*-*- Mode: C; c-basic-offset: 8; indent-tabs-mode: nil -*-*/
+
+/***
+  Copyright 2010 Lennart Poettering
+
+  Permission is hereby granted, free of charge, to any person
+  obtaining a copy of this software and associated documentation files
+  (the "Software"), to deal in the Software without restriction,
+  including without limitation the rights to use, copy, modify, merge,
+  publish, distribute, sublicense, and/or sell copies of the Software,
+  and to permit persons to whom the Software is furnished to do so,
+  subject to the following conditions:
+
+  The above copyright notice and this permission notice shall be
+  included in all copies or substantial portions of the Software.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+***/
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#ifdef __BIONIC__
+#include <linux/fcntl.h>
+#else
+#include <sys/fcntl.h>
+#endif
+#include <netinet/in.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stddef.h>
+#include <limits.h>
+
+#if defined(__linux__)
+#include <mqueue.h>
+#endif
+
+#include "sd-daemon.h"
+
+#if (__GNUC__ >= 4)
+#ifdef SD_EXPORT_SYMBOLS
+/* Export symbols */
+#define _sd_export_ __attribute__ ((visibility("default")))
+#else
+/* Don't export the symbols */
+#define _sd_export_ __attribute__ ((visibility("hidden")))
+#endif
+#else
+#define _sd_export_
+#endif
+
+_sd_export_ int sd_listen_fds(int unset_environment) {
+
+#if defined(DISABLE_SYSTEMD) || !defined(__linux__)
+        return 0;
+#else
+        int r, fd;
+        const char *e;
+        char *p = NULL;
+        unsigned long l;
+
+        if (!(e = getenv("LISTEN_PID"))) {
+                r = 0;
+                goto finish;
+        }
+
+        errno = 0;
+        l = strtoul(e, &p, 10);
+
+        if (errno != 0) {
+                r = -errno;
+                goto finish;
+        }
+
+        if (!p || *p || l <= 0) {
+                r = -EINVAL;
+                goto finish;
+        }
+
+        /* Is this for us? */
+        if (getpid() != (pid_t) l) {
+                r = 0;
+                goto finish;
+        }
+
+        if (!(e = getenv("LISTEN_FDS"))) {
+                r = 0;
+                goto finish;
+        }
+
+        errno = 0;
+        l = strtoul(e, &p, 10);
+
+        if (errno != 0) {
+                r = -errno;
+                goto finish;
+        }
+
+        if (!p || *p) {
+                r = -EINVAL;
+                goto finish;
+        }
+
+        for (fd = SD_LISTEN_FDS_START; fd < SD_LISTEN_FDS_START + (int) l; fd ++) {
+                int flags;
+
+                if ((flags = fcntl(fd, F_GETFD)) < 0) {
+                        r = -errno;
+                        goto finish;
+                }
+
+                if (flags & FD_CLOEXEC)
+                        continue;
+
+                if (fcntl(fd, F_SETFD, flags | FD_CLOEXEC) < 0) {
+                        r = -errno;
+                        goto finish;
+                }
+        }
+
+        r = (int) l;
+
+finish:
+        if (unset_environment) {
+                unsetenv("LISTEN_PID");
+                unsetenv("LISTEN_FDS");
+        }
+
+        return r;
+#endif
+}
+
+_sd_export_ int sd_is_fifo(int fd, const char *path) {
+        struct stat st_fd;
+
+        if (fd < 0)
+                return -EINVAL;
+
+        memset(&st_fd, 0, sizeof(st_fd));
+        if (fstat(fd, &st_fd) < 0)
+                return -errno;
+
+        if (!S_ISFIFO(st_fd.st_mode))
+                return 0;
+
+        if (path) {
+                struct stat st_path;
+
+                memset(&st_path, 0, sizeof(st_path));
+                if (stat(path, &st_path) < 0) {
+
+                        if (errno == ENOENT || errno == ENOTDIR)
+                                return 0;
+
+                        return -errno;
+                }
+
+                return
+                        st_path.st_dev == st_fd.st_dev &&
+                        st_path.st_ino == st_fd.st_ino;
+        }
+
+        return 1;
+}
+
+_sd_export_ int sd_is_special(int fd, const char *path) {
+        struct stat st_fd;
+
+        if (fd < 0)
+                return -EINVAL;
+
+        if (fstat(fd, &st_fd) < 0)
+                return -errno;
+
+        if (!S_ISREG(st_fd.st_mode) && !S_ISCHR(st_fd.st_mode))
+                return 0;
+
+        if (path) {
+                struct stat st_path;
+
+                if (stat(path, &st_path) < 0) {
+
+                        if (errno == ENOENT || errno == ENOTDIR)
+                                return 0;
+
+                        return -errno;
+                }
+
+                if (S_ISREG(st_fd.st_mode) && S_ISREG(st_path.st_mode))
+                        return
+                                st_path.st_dev == st_fd.st_dev &&
+                                st_path.st_ino == st_fd.st_ino;
+                else if (S_ISCHR(st_fd.st_mode) && S_ISCHR(st_path.st_mode))
+                        return st_path.st_rdev == st_fd.st_rdev;
+                else
+                        return 0;
+        }
+
+        return 1;
+}
+
+static int sd_is_socket_internal(int fd, int type, int listening) {
+        struct stat st_fd;
+
+        if (fd < 0 || type < 0)
+                return -EINVAL;
+
+        if (fstat(fd, &st_fd) < 0)
+                return -errno;
+
+        if (!S_ISSOCK(st_fd.st_mode))
+                return 0;
+
+        if (type != 0) {
+                int other_type = 0;
+                socklen_t l = sizeof(other_type);
+
+                if (getsockopt(fd, SOL_SOCKET, SO_TYPE, &other_type, &l) < 0)
+                        return -errno;
+
+                if (l != sizeof(other_type))
+                        return -EINVAL;
+
+                if (other_type != type)
+                        return 0;
+        }
+
+        if (listening >= 0) {
+                int accepting = 0;
+                socklen_t l = sizeof(accepting);
+
+                if (getsockopt(fd, SOL_SOCKET, SO_ACCEPTCONN, &accepting, &l) < 0)
+                        return -errno;
+
+                if (l != sizeof(accepting))
+                        return -EINVAL;
+
+                if (!accepting != !listening)
+                        return 0;
+        }
+
+        return 1;
+}
+
+union sockaddr_union {
+        struct sockaddr sa;
+        struct sockaddr_in in4;
+        struct sockaddr_in6 in6;
+        struct sockaddr_un un;
+        struct sockaddr_storage storage;
+};
+
+_sd_export_ int sd_is_socket(int fd, int family, int type, int listening) {
+        int r;
+
+        if (family < 0)
+                return -EINVAL;
+
+        if ((r = sd_is_socket_internal(fd, type, listening)) <= 0)
+                return r;
+
+        if (family > 0) {
+                union sockaddr_union sockaddr;
+                socklen_t l;
+
+                memset(&sockaddr, 0, sizeof(sockaddr));
+                l = sizeof(sockaddr);
+
+                if (getsockname(fd, &sockaddr.sa, &l) < 0)
+                        return -errno;
+
+                if (l < sizeof(sa_family_t))
+                        return -EINVAL;
+
+                return sockaddr.sa.sa_family == family;
+        }
+
+        return 1;
+}
+
+_sd_export_ int sd_is_socket_inet(int fd, int family, int type, int listening, uint16_t port) {
+        union sockaddr_union sockaddr;
+        socklen_t l;
+        int r;
+
+        if (family != 0 && family != AF_INET && family != AF_INET6)
+                return -EINVAL;
+
+        if ((r = sd_is_socket_internal(fd, type, listening)) <= 0)
+                return r;
+
+        memset(&sockaddr, 0, sizeof(sockaddr));
+        l = sizeof(sockaddr);
+
+        if (getsockname(fd, &sockaddr.sa, &l) < 0)
+                return -errno;
+
+        if (l < sizeof(sa_family_t))
+                return -EINVAL;
+
+        if (sockaddr.sa.sa_family != AF_INET &&
+            sockaddr.sa.sa_family != AF_INET6)
+                return 0;
+
+        if (family > 0)
+                if (sockaddr.sa.sa_family != family)
+                        return 0;
+
+        if (port > 0) {
+                if (sockaddr.sa.sa_family == AF_INET) {
+                        if (l < sizeof(struct sockaddr_in))
+                                return -EINVAL;
+
+                        return htons(port) == sockaddr.in4.sin_port;
+                } else {
+                        if (l < sizeof(struct sockaddr_in6))
+                                return -EINVAL;
+
+                        return htons(port) == sockaddr.in6.sin6_port;
+                }
+        }
+
+        return 1;
+}
+
+_sd_export_ int sd_is_socket_unix(int fd, int type, int listening, const char *path, size_t length) {
+        union sockaddr_union sockaddr;
+        socklen_t l;
+        int r;
+
+        if ((r = sd_is_socket_internal(fd, type, listening)) <= 0)
+                return r;
+
+        memset(&sockaddr, 0, sizeof(sockaddr));
+        l = sizeof(sockaddr);
+
+        if (getsockname(fd, &sockaddr.sa, &l) < 0)
+                return -errno;
+
+        if (l < sizeof(sa_family_t))
+                return -EINVAL;
+
+        if (sockaddr.sa.sa_family != AF_UNIX)
+                return 0;
+
+        if (path) {
+                if (length <= 0)
+                        length = strlen(path);
+
+                if (length <= 0)
+                        /* Unnamed socket */
+                        return l == offsetof(struct sockaddr_un, sun_path);
+
+                if (path[0])
+                        /* Normal path socket */
+                        return
+                                (l >= offsetof(struct sockaddr_un, sun_path) + length + 1) &&
+                                memcmp(path, sockaddr.un.sun_path, length+1) == 0;
+                else
+                        /* Abstract namespace socket */
+                        return
+                                (l == offsetof(struct sockaddr_un, sun_path) + length) &&
+                                memcmp(path, sockaddr.un.sun_path, length) == 0;
+        }
+
+        return 1;
+}
+
+_sd_export_ int sd_is_mq(int fd, const char *path) {
+#if !defined(__linux__)
+        return 0;
+#else
+        struct mq_attr attr;
+
+        if (fd < 0)
+                return -EINVAL;
+
+        if (mq_getattr(fd, &attr) < 0)
+                return -errno;
+
+        if (path) {
+                char fpath[PATH_MAX];
+                struct stat a, b;
+
+                if (path[0] != '/')
+                        return -EINVAL;
+
+                if (fstat(fd, &a) < 0)
+                        return -errno;
+
+                strncpy(stpcpy(fpath, "/dev/mqueue"), path, sizeof(fpath) - 12);
+                fpath[sizeof(fpath)-1] = 0;
+
+                if (stat(fpath, &b) < 0)
+                        return -errno;
+
+                if (a.st_dev != b.st_dev ||
+                    a.st_ino != b.st_ino)
+                        return 0;
+        }
+
+        return 1;
+#endif
+}
+
+_sd_export_ int sd_notify(int unset_environment, const char *state) {
+#if defined(DISABLE_SYSTEMD) || !defined(__linux__) || !defined(SOCK_CLOEXEC)
+        return 0;
+#else
+        int fd = -1, r;
+        struct msghdr msghdr;
+        struct iovec iovec;
+        union sockaddr_union sockaddr;
+        const char *e;
+
+        if (!state) {
+                r = -EINVAL;
+                goto finish;
+        }
+
+        if (!(e = getenv("NOTIFY_SOCKET")))
+                return 0;
+
+        /* Must be an abstract socket, or an absolute path */
+        if ((e[0] != '@' && e[0] != '/') || e[1] == 0) {
+                r = -EINVAL;
+                goto finish;
+        }
+
+        if ((fd = socket(AF_UNIX, SOCK_DGRAM|SOCK_CLOEXEC, 0)) < 0) {
+                r = -errno;
+                goto finish;
+        }
+
+        memset(&sockaddr, 0, sizeof(sockaddr));
+        sockaddr.sa.sa_family = AF_UNIX;
+        strncpy(sockaddr.un.sun_path, e, sizeof(sockaddr.un.sun_path));
+
+        if (sockaddr.un.sun_path[0] == '@')
+                sockaddr.un.sun_path[0] = 0;
+
+        memset(&iovec, 0, sizeof(iovec));
+        iovec.iov_base = (char*) state;
+        iovec.iov_len = strlen(state);
+
+        memset(&msghdr, 0, sizeof(msghdr));
+        msghdr.msg_name = &sockaddr;
+        msghdr.msg_namelen = offsetof(struct sockaddr_un, sun_path) + strlen(e);
+
+        if (msghdr.msg_namelen > sizeof(struct sockaddr_un))
+                msghdr.msg_namelen = sizeof(struct sockaddr_un);
+
+        msghdr.msg_iov = &iovec;
+        msghdr.msg_iovlen = 1;
+
+        if (sendmsg(fd, &msghdr, MSG_NOSIGNAL) < 0) {
+                r = -errno;
+                goto finish;
+        }
+
+        r = 1;
+
+finish:
+        if (unset_environment)
+                unsetenv("NOTIFY_SOCKET");
+
+        if (fd >= 0)
+                close(fd);
+
+        return r;
+#endif
+}
+
+_sd_export_ int sd_notifyf(int unset_environment, const char *format, ...) {
+#if defined(DISABLE_SYSTEMD) || !defined(__linux__)
+        return 0;
+#else
+        va_list ap;
+        char *p = NULL;
+        int r;
+
+        va_start(ap, format);
+        r = vasprintf(&p, format, ap);
+        va_end(ap);
+
+        if (r < 0 || !p)
+                return -ENOMEM;
+
+        r = sd_notify(unset_environment, p);
+        free(p);
+
+        return r;
+#endif
+}
+
+_sd_export_ int sd_booted(void) {
+#if defined(DISABLE_SYSTEMD) || !defined(__linux__)
+        return 0;
+#else
+
+        struct stat a, b;
+
+        /* We simply test whether the systemd cgroup hierarchy is
+         * mounted */
+
+        if (lstat("/sys/fs/cgroup", &a) < 0)
+                return 0;
+
+        if (lstat("/sys/fs/cgroup/systemd", &b) < 0)
+                return 0;
+
+        return a.st_dev != b.st_dev;
+#endif
+}
diff --git a/misc-utils/sd-daemon.h b/misc-utils/sd-daemon.h
new file mode 100644
index 0000000..fe51159
--- /dev/null
+++ b/misc-utils/sd-daemon.h
@@ -0,0 +1,282 @@
+/*-*- Mode: C; c-basic-offset: 8; indent-tabs-mode: nil -*-*/
+
+#ifndef foosddaemonhfoo
+#define foosddaemonhfoo
+
+/***
+  Copyright 2010 Lennart Poettering
+
+  Permission is hereby granted, free of charge, to any person
+  obtaining a copy of this software and associated documentation files
+  (the "Software"), to deal in the Software without restriction,
+  including without limitation the rights to use, copy, modify, merge,
+  publish, distribute, sublicense, and/or sell copies of the Software,
+  and to permit persons to whom the Software is furnished to do so,
+  subject to the following conditions:
+
+  The above copyright notice and this permission notice shall be
+  included in all copies or substantial portions of the Software.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+***/
+
+#include <sys/types.h>
+#include <inttypes.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+  Reference implementation of a few systemd related interfaces for
+  writing daemons. These interfaces are trivial to implement. To
+  simplify porting we provide this reference implementation.
+  Applications are welcome to reimplement the algorithms described
+  here if they do not want to include these two source files.
+
+  The following functionality is provided:
+
+  - Support for logging with log levels on stderr
+  - File descriptor passing for socket-based activation
+  - Daemon startup and status notification
+  - Detection of systemd boots
+
+  You may compile this with -DDISABLE_SYSTEMD to disable systemd
+  support. This makes all those calls NOPs that are directly related to
+  systemd (i.e. only sd_is_xxx() will stay useful).
+
+  Since this is drop-in code we don't want any of our symbols to be
+  exported in any case. Hence we declare hidden visibility for all of
+  them.
+
+  You may find an up-to-date version of these source files online:
+
+  http://cgit.freedesktop.org/systemd/systemd/plain/src/systemd/sd-daemon.h
+  http://cgit.freedesktop.org/systemd/systemd/plain/src/sd-daemon.c
+
+  This should compile on non-Linux systems, too, but with the
+  exception of the sd_is_xxx() calls all functions will become NOPs.
+
+  See sd-daemon(7) for more information.
+*/
+
+#ifndef _sd_printf_attr_
+#if __GNUC__ >= 4
+#define _sd_printf_attr_(a,b) __attribute__ ((format (printf, a, b)))
+#else
+#define _sd_printf_attr_(a,b)
+#endif
+#endif
+
+/*
+  Log levels for usage on stderr:
+
+          fprintf(stderr, SD_NOTICE "Hello World!\n");
+
+  This is similar to printk() usage in the kernel.
+*/
+#define SD_EMERG   "<0>"  /* system is unusable */
+#define SD_ALERT   "<1>"  /* action must be taken immediately */
+#define SD_CRIT    "<2>"  /* critical conditions */
+#define SD_ERR     "<3>"  /* error conditions */
+#define SD_WARNING "<4>"  /* warning conditions */
+#define SD_NOTICE  "<5>"  /* normal but significant condition */
+#define SD_INFO    "<6>"  /* informational */
+#define SD_DEBUG   "<7>"  /* debug-level messages */
+
+/* The first passed file descriptor is fd 3 */
+#define SD_LISTEN_FDS_START 3
+
+/*
+  Returns how many file descriptors have been passed, or a negative
+  errno code on failure. Optionally, removes the $LISTEN_FDS and
+  $LISTEN_PID file descriptors from the environment (recommended, but
+  problematic in threaded environments). If r is the return value of
+  this function you'll find the file descriptors passed as fds
+  SD_LISTEN_FDS_START to SD_LISTEN_FDS_START+r-1. Returns a negative
+  errno style error code on failure. This function call ensures that
+  the FD_CLOEXEC flag is set for the passed file descriptors, to make
+  sure they are not passed on to child processes. If FD_CLOEXEC shall
+  not be set, the caller needs to unset it after this call for all file
+  descriptors that are used.
+
+  See sd_listen_fds(3) for more information.
+*/
+int sd_listen_fds(int unset_environment);
+
+/*
+  Helper call for identifying a passed file descriptor. Returns 1 if
+  the file descriptor is a FIFO in the file system stored under the
+  specified path, 0 otherwise. If path is NULL a path name check will
+  not be done and the call only verifies if the file descriptor
+  refers to a FIFO. Returns a negative errno style error code on
+  failure.
+
+  See sd_is_fifo(3) for more information.
+*/
+int sd_is_fifo(int fd, const char *path);
+
+/*
+  Helper call for identifying a passed file descriptor. Returns 1 if
+  the file descriptor is a special character device on the file
+  system stored under the specified path, 0 otherwise.
+  If path is NULL a path name check will not be done and the call
+  only verifies if the file descriptor refers to a special character.
+  Returns a negative errno style error code on failure.
+
+  See sd_is_special(3) for more information.
+*/
+int sd_is_special(int fd, const char *path);
+
+/*
+  Helper call for identifying a passed file descriptor. Returns 1 if
+  the file descriptor is a socket of the specified family (AF_INET,
+  ...) and type (SOCK_DGRAM, SOCK_STREAM, ...), 0 otherwise. If
+  family is 0 a socket family check will not be done. If type is 0 a
+  socket type check will not be done and the call only verifies if
+  the file descriptor refers to a socket. If listening is > 0 it is
+  verified that the socket is in listening mode. (i.e. listen() has
+  been called) If listening is == 0 it is verified that the socket is
+  not in listening mode. If listening is < 0 no listening mode check
+  is done. Returns a negative errno style error code on failure.
+
+  See sd_is_socket(3) for more information.
+*/
+int sd_is_socket(int fd, int family, int type, int listening);
+
+/*
+  Helper call for identifying a passed file descriptor. Returns 1 if
+  the file descriptor is an Internet socket, of the specified family
+  (either AF_INET or AF_INET6) and the specified type (SOCK_DGRAM,
+  SOCK_STREAM, ...), 0 otherwise. If version is 0 a protocol version
+  check is not done. If type is 0 a socket type check will not be
+  done. If port is 0 a socket port check will not be done. The
+  listening flag is used the same way as in sd_is_socket(). Returns a
+  negative errno style error code on failure.
+
+  See sd_is_socket_inet(3) for more information.
+*/
+int sd_is_socket_inet(int fd, int family, int type, int listening, uint16_t port);
+
+/*
+  Helper call for identifying a passed file descriptor. Returns 1 if
+  the file descriptor is an AF_UNIX socket of the specified type
+  (SOCK_DGRAM, SOCK_STREAM, ...) and path, 0 otherwise. If type is 0
+  a socket type check will not be done. If path is NULL a socket path
+  check will not be done. For normal AF_UNIX sockets set length to
+  0. For abstract namespace sockets set length to the length of the
+  socket name (including the initial 0 byte), and pass the full
+  socket path in path (including the initial 0 byte). The listening
+  flag is used the same way as in sd_is_socket(). Returns a negative
+  errno style error code on failure.
+
+  See sd_is_socket_unix(3) for more information.
+*/
+int sd_is_socket_unix(int fd, int type, int listening, const char *path, size_t length);
+
+/*
+  Helper call for identifying a passed file descriptor. Returns 1 if
+  the file descriptor is a POSIX Message Queue of the specified name,
+  0 otherwise. If path is NULL a message queue name check is not
+  done. Returns a negative errno style error code on failure.
+*/
+int sd_is_mq(int fd, const char *path);
+
+/*
+  Informs systemd about changed daemon state. This takes a number of
+  newline separated environment-style variable assignments in a
+  string. The following variables are known:
+
+     READY=1      Tells systemd that daemon startup is finished (only
+                  relevant for services of Type=notify). The passed
+                  argument is a boolean "1" or "0". Since there is
+                  little value in signaling non-readiness the only
+                  value daemons should send is "READY=1".
+
+     STATUS=...   Passes a single-line status string back to systemd
+                  that describes the daemon state. This is free-from
+                  and can be used for various purposes: general state
+                  feedback, fsck-like programs could pass completion
+                  percentages and failing programs could pass a human
+                  readable error message. Example: "STATUS=Completed
+                  66% of file system check..."
+
+     ERRNO=...    If a daemon fails, the errno-style error code,
+                  formatted as string. Example: "ERRNO=2" for ENOENT.
+
+     BUSERROR=... If a daemon fails, the D-Bus error-style error
+                  code. Example: "BUSERROR=org.freedesktop.DBus.Error.TimedOut"
+
+     MAINPID=...  The main pid of a daemon, in case systemd did not
+                  fork off the process itself. Example: "MAINPID=4711"
+
+     WATCHDOG=1   Tells systemd to update the watchdog timestamp.
+                  Services using this feature should do this in
+                  regular intervals. A watchdog framework can use the
+                  timestamps to detect failed services.
+
+  Daemons can choose to send additional variables. However, it is
+  recommended to prefix variable names not listed above with X_.
+
+  Returns a negative errno-style error code on failure. Returns > 0
+  if systemd could be notified, 0 if it couldn't possibly because
+  systemd is not running.
+
+  Example: When a daemon finished starting up, it could issue this
+  call to notify systemd about it:
+
+     sd_notify(0, "READY=1");
+
+  See sd_notifyf() for more complete examples.
+
+  See sd_notify(3) for more information.
+*/
+int sd_notify(int unset_environment, const char *state);
+
+/*
+  Similar to sd_notify() but takes a format string.
+
+  Example 1: A daemon could send the following after initialization:
+
+     sd_notifyf(0, "READY=1\n"
+                   "STATUS=Processing requests...\n"
+                   "MAINPID=%lu",
+                   (unsigned long) getpid());
+
+  Example 2: A daemon could send the following shortly before
+  exiting, on failure:
+
+     sd_notifyf(0, "STATUS=Failed to start up: %s\n"
+                   "ERRNO=%i",
+                   strerror(errno),
+                   errno);
+
+  See sd_notifyf(3) for more information.
+*/
+int sd_notifyf(int unset_environment, const char *format, ...) _sd_printf_attr_(2,3);
+
+/*
+  Returns > 0 if the system was booted with systemd. Returns < 0 on
+  error. Returns 0 if the system was not booted with systemd. Note
+  that all of the functions above handle non-systemd boots just
+  fine. You should NOT protect them with a call to this function. Also
+  note that this function checks whether the system, not the user
+  session is controlled by systemd. However the functions above work
+  for both user and system services.
+
+  See sd_booted(3) for more information.
+*/
+int sd_booted(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/misc-utils/uuidd.8 b/misc-utils/uuidd.8
index e3ccf6f..f5fb5f0 100644
--- a/misc-utils/uuidd.8
+++ b/misc-utils/uuidd.8
@@ -42,6 +42,12 @@ Do not create pid file.
 .BR \-F , " \-\-no-fork "
 Do not daemonize using double-fork.
 .TP
+.BR \-S , " \-\-socket-activation "
+Do not create the socket and instead expect it to be provided by the calling
+process.  Implies --no-fork and --no-pid.  As of this writing, this option is
+supposed to be used only with systemd. It needs to enabled with configure
+option --enable--uuid-socket-activation.
+.TP
 .B \-q
 Suppress some failure messages.
 .TP
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index a135816..abc24a4 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -35,6 +35,10 @@ extern int optind;
 #include "uuidd.h"
 #include "writeall.h"
 
+#ifdef UUIDD_SOCKET_ACTIVATION
+#include "sd-daemon.h"
+#endif
+
 #include "nls.h"
 
 #ifdef __GNUC__
@@ -56,19 +60,20 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	      _(" %s [options]\n"), program_invocation_short_name);
 
 	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -p, --pid <path>    path to pid file\n"
-		" -s, --socket <path> path to socket\n"
-		" -T, --timeout <sec> specify inactivity timeout\n"
-		" -k, --kill          kill running daemon\n"
-		" -r, --random        test random-based generation\n"
-		" -t, --time          test time-based generation\n"
-		" -n, --uuids <num>   request number of uuids\n"
-		" -P, --no-pid        do not create pid file\n"
-		" -F, --no-fork       do not daemonize using double-fork\n"
-		" -d, --debug         run in debugging mode\n"
-		" -q, --quiet         turn on quiet mode\n"
-		" -V, --version       output version information and exit\n"
-		" -h, --help          display this help and exit\n\n"), out);
+	fputs(_(" -p, --pid <path>        path to pid file\n"
+		" -s, --socket <path>     path to socket\n"
+		" -T, --timeout <sec>     specify inactivity timeout\n"
+		" -k, --kill              kill running daemon\n"
+		" -r, --random            test random-based generation\n"
+		" -t, --time              test time-based generation\n"
+		" -n, --uuids <num>       request number of uuids\n"
+		" -P, --no-pid            do not create pid file\n"
+		" -F, --no-fork           do not daemonize using double-fork\n"
+		" -S, --socket-activation do not create listening socket\n"
+		" -d, --debug             run in debugging mode\n"
+		" -q, --quiet             turn on quiet mode\n"
+		" -V, --version           output version information and exit\n"
+		" -h, --help              display this help and exit\n\n"), out);
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -300,7 +305,8 @@ static int create_socket(const char *socket_path, int will_fork, int quiet)
 }
 
 static void server_loop(const char *socket_path, const char *pidfile_path,
-			int debug, int timeout, int quiet, int no_fork)
+			int debug, int timeout, int quiet, int no_fork,
+			int no_sock)
 {
 	struct sockaddr_un	from_addr;
 	socklen_t		fromlen;
@@ -312,9 +318,14 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	int			fd_pidfile = -1;
 	int			ret;
 
+#ifdef UUIDD_SOCKET_ACTIVATION
+	if (no_sock)
+		/* no_sock implies no_fork and no_pid */
+		goto socket_ready;
+#endif
+
 	signal(SIGALRM, terminate_intr);
 	alarm(30);
-
 	if (pidfile_path)
 		fd_pidfile = create_pidfile(pidfile_path, quiet);
 
@@ -337,11 +348,6 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 
 	if (!debug && !no_fork)
 		create_daemon();
-	signal(SIGHUP, terminate_intr);
-	signal(SIGINT, terminate_intr);
-	signal(SIGTERM, terminate_intr);
-	signal(SIGALRM, terminate_intr);
-	signal(SIGPIPE, SIG_IGN);
 
 	if (pidfile_path) {
 		sprintf(reply_buf, "%8d\n", getpid());
@@ -353,6 +359,24 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			close(fd_pidfile); /* Unlock the pid file */
 	}
 
+socket_ready:
+	signal(SIGHUP, terminate_intr);
+	signal(SIGINT, terminate_intr);
+	signal(SIGTERM, terminate_intr);
+	signal(SIGALRM, terminate_intr);
+	signal(SIGPIPE, SIG_IGN);
+
+#ifdef UUIDD_SOCKET_ACTIVATION
+	if (no_sock) {
+		if (sd_listen_fds(0) != 1) {
+			fprintf(stderr, _("No or too many file descriptors received.\n"));
+			exit(EXIT_FAILURE);
+		}
+
+		s = SD_LISTEN_FDS_START + 0;
+	}
+#endif
+
 	while (1) {
 		fromlen = sizeof(from_addr);
 		if (timeout > 0)
@@ -482,6 +506,7 @@ int main(int argc, char **argv)
 	int		debug = 0, do_type = 0, do_kill = 0, num = 0;
 	int		timeout = 0, quiet = 0, drop_privs = 0;
 	int		no_pid = 0, no_fork = 0;
+	int		no_sock = 0, s_flag = 0;
 
 	static const struct option longopts[] = {
 		{"pid", required_argument, NULL, 'p'},
@@ -493,6 +518,7 @@ int main(int argc, char **argv)
 		{"uuids", required_argument, NULL, 'n'},
 		{"no-pid", no_argument, NULL, 'P'},
 		{"no-fork", no_argument, NULL, 'F'},
+		{"socket-activation", no_argument, NULL, 'S'},
 		{"debug", no_argument, NULL, 'd'},
 		{"quiet", no_argument, NULL, 'q'},
 		{"version", no_argument, NULL, 'V'},
@@ -505,7 +531,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 
 	while ((c =
-		getopt_long(argc, argv, "p:s:T:krtn:PFdqVh", longopts,
+		getopt_long(argc, argv, "p:s:T:krtn:PFSdqVh", longopts,
 			    NULL)) != -1) {
 		switch (c) {
 		case 'd':
@@ -535,6 +561,19 @@ int main(int argc, char **argv)
 			no_fork = 1;
 			drop_privs = 1;
 			break;
+		case 'S':
+#ifdef UUIDD_SOCKET_ACTIVATION
+			no_sock = 1;
+			drop_privs = 1;
+			no_fork = 1;
+			no_pid = 1;
+#else
+			fprintf(stderr,
+				_("uuidd has been built without support for socket activation.\n"
+				  "Configure with --enable-uuidd-socket-activation to enable it.\n"));
+			return EXIT_FAILURE;
+#endif
+			break;
 		case 'q':
 			quiet++;
 			break;
@@ -544,6 +583,7 @@ int main(int argc, char **argv)
 			break;
 		case 's':
 			socket_path = optarg;
+			s_flag = 1;
 			drop_privs = 1;
 			break;
 		case 't':
@@ -578,6 +618,10 @@ int main(int argc, char **argv)
 	else if (pidfile_path_param)
 		pidfile_path = pidfile_path_param;
 
+	/* custom socket path and socket-activation make no sense */
+	if (s_flag && no_sock && !quiet)
+		fprintf(stderr, _("Both --socket-activation and --socket specified. "
+				  "Ignoring --socket\n"));
 
 	uid = getuid();
 	if (uid && drop_privs) {
@@ -660,6 +704,7 @@ int main(int argc, char **argv)
 		return EXIT_SUCCESS;
 	}
 
-	server_loop(socket_path, pidfile_path, debug, timeout, quiet, no_fork);
+	server_loop(socket_path, pidfile_path, debug, timeout, quiet, no_fork,
+		    no_sock);
 	return EXIT_SUCCESS;
 }
-- 
1.7.7

