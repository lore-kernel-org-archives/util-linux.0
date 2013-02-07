Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f179.google.com ([209.85.223.179]:50219 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3BGGWn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Feb 2013 01:22:43 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so3048852iea.10
        for <util-linux@vger.kernel.org>; Wed, 06 Feb 2013 22:22:42 -0800 (PST)
From: Cody Maloney <cmaloney@theoreticalchaos.com>
To: util-linux@vger.kernel.org
Cc: mitr@redhat.com, Cody Maloney <cmaloney@theoreticalchaos.com>
Subject: [PATCH v3 1/4] chsh-chfn: Add flag for enabling/disabling libuser support.
Date: Wed,  6 Feb 2013 23:22:18 -0700
Message-Id: <1360218141-4463-2-git-send-email-cmaloney@theoreticalchaos.com>
In-Reply-To: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
References: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Cody Maloney <cmaloney@theoreticalchaos.com>
---
 configure.ac              | 17 +++++++++++++++++
 login-utils/Makemodule.am |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/configure.ac b/configure.ac
index d26a686..cf6e922 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1126,6 +1126,23 @@ AS_HELP_STRING([--disable-chsh-only-listed], [chsh: allow shells not in /etc/she
 [], enable_chsh_only_listed=yes
 )
 
+AC_ARG_WITH([libuser], AS_HELP_STRING([--without-libuser], [compile without libuser (remote chsh)]),
+  [], with_user=auto
+)
+
+if test "x$with_user" = xno; then
+  AM_CONDITIONAL(HAVE_USER, false)
+else
+  PKG_CHECK_MODULES(LIBUSER,[libuser >= 0.58])
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

