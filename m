Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53096 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758221Ab2ECTCM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:12 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 62F469664A
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:11 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 12/15] uuidd: add systemd unit files
Date: Thu,  3 May 2012 21:01:58 +0200
Message-Id: <1336071721-32492-13-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add systemd unit files which use the socket activation mechanism
of systemd. The uuidd deamon is started upon first request on the
socket and quits after 1 minute of inactivity.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 Makefile.am                 |    3 ++-
 configure.ac                |   11 +++++++++++
 misc-utils/.gitignore       |    1 +
 misc-utils/Makefile.am      |   11 +++++++++--
 misc-utils/uuidd.service.in |    9 +++++++++
 misc-utils/uuidd.socket     |    8 ++++++++
 6 files changed, 40 insertions(+), 3 deletions(-)
 create mode 100644 misc-utils/uuidd.service.in
 create mode 100644 misc-utils/uuidd.socket

diff --git a/Makefile.am b/Makefile.am
index 6fec32d..12e1103 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -89,7 +89,8 @@ checkxalloc:
 
 ENABLE_ALL = --enable-static-programs --enable-most-builds
 DISTCHECK_CONFIGURE_FLAGS = --enable-gtk-doc --disable-use-tty-group \
-			    --disable-silent-rules $(ENABLE_ALL)
+			    --disable-silent-rules $(ENABLE_ALL) \
+			    --with-systemdsystemunitdir=$$dc_install_base/$(systemdsystemunitdir)
 
 
 BUILT_SOURCES = .version
diff --git a/configure.ac b/configure.ac
index f5f3a2e..d254349 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1134,6 +1134,16 @@ if test "x$enable_socket_activation" = xyes; then
   AC_DEFINE(USE_SOCKET_ACTIVATION, 1, [Should uuidd support socket activation?])
 fi
 
+AC_ARG_WITH([systemdsystemunitdir],
+  AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [directory for systemd service files]),
+  [], [with_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)])
+
+if test "x$with_systemdsystemunitdir" != "xno"; then
+  AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])
+fi
+
+AM_CONDITIONAL(WITH_SYSTEMD, [test -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != "xno" ])
+
 
 AC_ARG_ENABLE([login-stat-mail],
   AS_HELP_STRING([--enable-login-stat-mail], [let login stat() the mailbox]),
@@ -1257,6 +1267,7 @@ libuuid/uuid.pc
 login-utils/Makefile
 man/ru/Makefile
 misc-utils/Makefile
+misc-utils/uuidd.service
 mount/Makefile
 partx/Makefile
 po/Makefile.in
diff --git a/misc-utils/.gitignore b/misc-utils/.gitignore
index 927af23..3fe5567 100644
--- a/misc-utils/.gitignore
+++ b/misc-utils/.gitignore
@@ -18,3 +18,4 @@ wipefs
 findmnt
 lsblk
 lslocks
+uuidd.service
diff --git a/misc-utils/Makefile.am b/misc-utils/Makefile.am
index 47a639b..9dd3583 100644
--- a/misc-utils/Makefile.am
+++ b/misc-utils/Makefile.am
@@ -1,7 +1,5 @@
 include $(top_srcdir)/config/include-Makefile.am
 
-EXTRA_DIST = uuidd.rc
-
 bin_PROGRAMS =
 sbin_PROGRAMS =
 usrsbin_exec_PROGRAMS =
@@ -89,8 +87,17 @@ if USE_SOCKET_ACTIVATION
 uuidd_SOURCES += sd-daemon.c
 uuidd_LDADD += -lrt
 endif
+if WITH_SYSTEMD
+systemdsystemunit_DATA = \
+	uuidd.service \
+	uuidd.socket
+endif
 endif
 
+EXTRA_DIST = uuidd.rc uuidd.service.in uuidd.socket
+CLEANFILES += uuidd.service
+
+
 if BUILD_LIBBLKID
 sbin_PROGRAMS += blkid findfs wipefs
 dist_man_MANS += blkid.8 findfs.8 wipefs.8
diff --git a/misc-utils/uuidd.service.in b/misc-utils/uuidd.service.in
new file mode 100644
index 0000000..750fc31
--- /dev/null
+++ b/misc-utils/uuidd.service.in
@@ -0,0 +1,9 @@
+[Unit]
+Description=Daemon for generating UUIDs
+Requires=uuidd.socket
+
+[Service]
+ExecStart=@sbindir@/uuidd -S -T 60
+Restart=no
+User=uuidd
+Group=uuidd
diff --git a/misc-utils/uuidd.socket b/misc-utils/uuidd.socket
new file mode 100644
index 0000000..4eba789
--- /dev/null
+++ b/misc-utils/uuidd.socket
@@ -0,0 +1,8 @@
+[Unit]
+Description=UUID daemon activation socket
+
+[Socket]
+ListenStream=/var/run/uuidd/request
+
+[Install]
+WantedBy=sockets.target
-- 
1.7.7

