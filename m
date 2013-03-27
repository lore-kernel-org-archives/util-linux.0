Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:45092 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab3C0WIG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 18:08:06 -0400
Received: by mail-wi0-f177.google.com with SMTP id hm14so2703534wib.16
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 15:08:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/10] bash-completion: add bash completetion configure option
Date: Wed, 27 Mar 2013 22:07:43 +0000
Message-Id: <1364422072-23552-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Makefile.am                    |  5 +++++
 configure.ac                   | 13 +++++++++++++
 shell-completion/Makemodule.am |  1 +
 3 files changed, 19 insertions(+)
 create mode 100644 shell-completion/Makemodule.am

diff --git a/Makefile.am b/Makefile.am
index 3afcad1..b963af9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -27,6 +27,8 @@ ul_libfdisk_incdir  = $(top_srcdir)/libfdisk/src
 
 pkgconfigdir = $(usrlib_execdir)/pkgconfig
 
+bashcompletiondir = @bashcompletiondir@
+
 dist_noinst_HEADERS =
 noinst_PROGRAMS =
 noinst_LTLIBRARIES =
@@ -87,6 +89,8 @@ include misc-utils/Makemodule.am
 include disk-utils/Makemodule.am
 include fdisks/Makemodule.am
 
+include shell-completion/Makemodule.am
+
 include tests/Makemodule.am
 
 #
@@ -158,6 +162,7 @@ checkdecl:
 ENABLE_ALL = --enable-static-programs --enable-most-builds
 DISTCHECK_CONFIGURE_FLAGS = --disable-use-tty-group \
 			    --disable-silent-rules $(ENABLE_ALL) \
+			    --with-bashcompletiondir=$$dc_install_base/$(bashcompletiondir) \
 			    --with-systemdsystemunitdir=$$dc_install_base/$(systemdsystemunitdir)
 
 
diff --git a/configure.ac b/configure.ac
index 92a5a3b..cd4e826 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1342,6 +1342,18 @@ fi
 AM_CONDITIONAL(HAVE_SYSTEMD, [test -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != "xno" ])
 
 
+AC_ARG_WITH([bashcompletiondir],
+  AS_HELP_STRING([--with-bashcompletiondir=DIR], [Bash completions directory]),
+  [],
+  [AS_IF([$($PKG_CONFIG --exists bash-completion)], [
+    with_bashcompletiondir=$($PKG_CONFIG --variable=completionsdir bash-completion)
+  ], [
+    with_bashcompletiondir=${datadir}/bash-completion/completions
+  ])
+])
+AC_SUBST([bashcompletiondir], [$with_bashcompletiondir])
+
+
 AC_ARG_ENABLE([pg-bell],
   AS_HELP_STRING([--disable-pg-bell], [let pg not ring the bell on invalid keys]),
   [], enable_pg_bell=yes
@@ -1463,6 +1475,7 @@ AC_MSG_RESULT([
 	suid cflags:       ${SUID_CFLAGS}
 	ldflags:           ${LDFLAGS}
 	suid ldflags:      ${SUID_LDFLAGS}
+	Bash completions dir: ${with_bashcompletiondir}
 
 	warnings:
 
diff --git a/shell-completion/Makemodule.am b/shell-completion/Makemodule.am
new file mode 100644
index 0000000..b784ec7
--- /dev/null
+++ b/shell-completion/Makemodule.am
@@ -0,0 +1 @@
+dist_bashcompletion_DATA =
-- 
1.8.2

