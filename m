Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50621 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759115Ab2C2Qpp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:45 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 10C02906EB
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:45 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 13/20] uuidd: add systemd unit files
Date: Thu, 29 Mar 2012 18:45:21 +0200
Message-Id: <1333039528-24784-14-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add systemd unit files which use the socket activation mechanism
of systemd. The uuidd deamon is started upon first request on the
socket and quits after 1 minute of inactivity.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 configure.ac                |   11 +++++++++++
 misc-utils/.gitignore       |    2 +-
 misc-utils/Makefile.am      |   11 +++++++++--
 misc-utils/uuidd.service.in |    9 +++++++++
 misc-utils/uuidd.socket     |    8 ++++++++
 5 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 misc-utils/uuidd.service.in
 create mode 100644 misc-utils/uuidd.socket

diff --git a/configure.ac b/configure.ac
index bb56948..8f89639 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1112,6 +1112,16 @@ if test "x$enable_uuidd_socket_activation" = xyes; then
   AC_DEFINE(UUIDD_SOCKET_ACTIVATION, 1, [Should uuidd support socket activation?])
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
@@ -1235,6 +1245,7 @@ libuuid/uuid.pc
 login-utils/Makefile
 man/ru/Makefile
 misc-utils/Makefile
+misc-utils/uuidd.service
 misc-utils/chkdupexe:misc-utils/chkdupexe.pl
 mount/Makefile
 partx/Makefile
diff --git a/misc-utils/.gitignore b/misc-utils/.gitignore
index bde3ab8..3fe5567 100644
--- a/misc-utils/.gitignore
+++ b/misc-utils/.gitignore
@@ -18,4 +18,4 @@ wipefs
 findmnt
 lsblk
 lslocks
-
+uuidd.service
diff --git a/misc-utils/Makefile.am b/misc-utils/Makefile.am
index 5db5183..e0232e8 100644
--- a/misc-utils/Makefile.am
+++ b/misc-utils/Makefile.am
@@ -1,7 +1,5 @@
 include $(top_srcdir)/config/include-Makefile.am
 
-EXTRA_DIST = uuidd.rc
-
 bin_PROGRAMS =
 sbin_PROGRAMS =
 usrsbin_exec_PROGRAMS =
@@ -85,8 +83,17 @@ if UUIDD_SOCKET_ACTIVATION
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

