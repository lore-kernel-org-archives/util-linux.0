Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f44.google.com ([209.85.160.44]:52668 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab3ACDad (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Jan 2013 22:30:33 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so8264565pbc.17
        for <util-linux@vger.kernel.org>; Wed, 02 Jan 2013 19:30:32 -0800 (PST)
From: Cody Maloney <cmaloney@theoreticalchaos.com>
To: util-linux@vger.kernel.org
Cc: mitr@redhat.com, Cody Maloney <cmaloney@theoreticalchaos.com>
Subject: [PATCH 1/3] chsh-chfn: Add flag for enabling/disabling libuser support.
Date: Wed,  2 Jan 2013 20:21:59 -0700
Message-Id: <1357183321-24637-2-git-send-email-cmaloney@theoreticalchaos.com>
In-Reply-To: <1357183321-24637-1-git-send-email-cmaloney@theoreticalchaos.com>
References: <1357183321-24637-1-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 configure.ac              | 17 +++++++++++++++++
 login-utils/Makemodule.am |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/configure.ac b/configure.ac
index 9c08fc0..bfe8cba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1095,6 +1095,23 @@ AS_HELP_STRING([--disable-chsh-only-listed], [chsh: allow shells not in /etc/she
 [], enable_chsh_only_listed=yes
 )
 
+AC_ARG_WITH([libuser], AS_HELP_STRING([--without-libuser], [compile without libuser (remote chsh)]),
+  [], with_user=auto
+)
+
+if test "x$with_user" = xno; then
+  AM_CONDITIONAL(HAVE_USER, false)
+else
+  PKG_CHECK_MODULES(LIBUSER,[libuser])
+  UL_CHECK_LIB(user, lu_start)
+  case "$with_user:$have_user" in
+  yes:no)
+   AC_MSG_ERROR([user selected but libuser not found])
+   ;;
+  esac
+fi
+
+
 if test "x$enable_chsh_only_listed" = xyes; then
 AC_DEFINE(ONLY_LISTED_SHELLS, 1, [Should chsh allow only shells in /etc/shells?])
 fi
diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index aef8177..479b87b 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -68,6 +68,11 @@ chfn_chsh_cflags = $(SUID_CFLAGS) $(AM_CFLAGS)
 chfn_chsh_ldflags = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 chfn_chsh_ldadd = libcommon.la -lpam -lpam_misc
 
+if HAVE_USER
+chfn_chsh_ldflags += $(LIBUSER_LIBS)
+chfn_chsh_cflags += $(LIBUSER_CFLAGS)
+endif
+
 if HAVE_SELINUX
 chfn_chsh_sources += \
 	login-utils/selinux_utils.c \
-- 
1.8.1

