Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
From: Sami Kerola <kerolasa@iki.fi>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>,
        Karel Zak <kzak@redhat.com>,
        Thomas =?iso-8859-1?q?B=E4chler?= <thomas@archlinux.org>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Date: Wed,  8 Jan 2014 22:28:06 +0000
Message-Id: <1389220086-7475-1-git-send-email-kerolasa@iki.fi>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi> <20140108092116.GA7516@x2.net.home> <CAG27Bk2S5ert+sjnai8ybEhhoUruYmX6P+U7c1AaghfjQ_s2TA@mail.gmail.com> <201401081544.37516.vapier@gentoo.org>
In-Reply-To: <201401081544.37516.vapier@gentoo.org>
List-ID: <util-linux.vger.kernel.org>

Hi Mike, and others,

So the change that's needed could be something like

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 8 Jan 2014 22:16:05 +0000
Subject: [PATCH] build-sys: add ./configure --enable-libraries-only option

The option is meant to help distributors to bootstrap systems out of
scratch.

Reference: http://www.spinics.net/lists/util-linux-ng/index.html#08695
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Makefile.am               | 12 ++++++++++++
 configure.ac              | 10 +++++++++-
 login-utils/Makemodule.am | 11 -----------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 17f4c33..24a7212 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -79,6 +79,7 @@ include libblkid/Makemodule.am
 include libmount/Makemodule.am
 include libfdisk/Makemodule.am
 
+if HAVE_COMMANDS
 include schedutils/Makemodule.am
 include text-utils/Makemodule.am
 include term-utils/Makemodule.am
@@ -92,6 +93,7 @@ include fdisks/Makemodule.am
 include bash-completion/Makemodule.am
 
 include tests/Makemodule.am
+endif	# HAVE_COMMANDS
 
 #
 # Don't rely on configure.ac AC_CONFIG_FILES for install paths.
@@ -191,6 +193,16 @@ checksmatch:
 changelog: $(CHANGELOG_FILE)
 
 install-exec-hook: $(INSTALL_EXEC_HOOKS)
+if HAVE_COMMANDS
+if BUILD_SU
+if MAKEINSTALL_DO_SETUID
+	chmod 4755 $(DESTDIR)$(bindir)/su
+endif
+endif	# BUILD_SU
+if BUILD_VIPW
+	cd $(DESTDIR)$(usrsbin_execdir) && ln -sf vipw vigr
+endif
+endif	# HAVE_COMMANDS
 
 uninstall-hook: $(UNINSTALL_HOOKS)
 
diff --git a/configure.ac b/configure.ac
index 6bf5048..d08589e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -704,6 +704,11 @@ AS_IF([test "x$with_utempter" = xyes], [
   AM_CONDITIONAL([HAVE_UTEMPTER], [false])
 ])
 
+AC_ARG_ENABLE([binaries],
+  AS_HELP_STRING([--disable-binaries], [build only libraries]),
+  [], [enable_libraries_only=yes]
+)
+AM_CONDITIONAL(HAVE_COMMANDS, test "x$enable_libraries_only" = xyes)
 
 AC_ARG_ENABLE([most-builds],
   AS_HELP_STRING([--enable-most-builds], [build everything other than experimental code]),
@@ -1570,7 +1575,10 @@ libblkid/src/blkid.h
 libmount/docs/Makefile
 libmount/docs/version.xml
 libmount/src/libmount.h
-po/Makefile.in
+])
+
+AS_IF([test "x$enable_libraries_only" = xyes], [
+  AC_CONFIG_FILES([po/Makefile.in])
 ])
 
 AC_OUTPUT
diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index aca028a..c57aca7 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -196,14 +196,3 @@ test_logindefs_SOURCES = \
 	login-utils/logindefs.c \
 	login-utils/logindefs.h
 test_logindefs_CPPFLAGS = -DTEST_PROGRAM $(AM_CPPFLAGS)
-
-
-install-exec-hook:
-if BUILD_SU
-if MAKEINSTALL_DO_SETUID
-	chmod 4755 $(DESTDIR)$(bindir)/su
-endif
-endif
-if BUILD_VIPW
-	cd $(DESTDIR)$(usrsbin_execdir) && ln -sf vipw vigr
-endif
-- 
1.8.5.2
