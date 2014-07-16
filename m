Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:64851 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751016AbaGPLKL (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Jul 2014 07:10:11 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] build-sys: harmonize some indentation
Date: Wed, 16 Jul 2014 13:09:53 +0200
Message-Id: <1405508993-8097-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1405508993-8097-1-git-send-email-bensberg@justemail.net>
References: <1405508993-8097-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 configure.ac |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1083752..0cf448c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1329,7 +1329,7 @@ AM_CONDITIONAL([BUILD_LINE], [test "x$build_line" = xyes])
 
 
 AC_ARG_ENABLE([mesg],
-	      AS_HELP_STRING([--disable-mesg], [do not build mesg]),
+  AS_HELP_STRING([--disable-mesg], [do not build mesg]),
   [], [UL_DEFAULT_ENABLE([mesg], [yes])]
 )
 UL_BUILD_INIT([mesg])
@@ -1337,7 +1337,7 @@ AM_CONDITIONAL([BUILD_MESG], [test "x$build_mesg" = xyes])
 
 
 AC_ARG_ENABLE([raw],
-	      AS_HELP_STRING([--disable-raw], [do not build raw]),
+  AS_HELP_STRING([--disable-raw], [do not build raw]),
   [], [UL_DEFAULT_ENABLE([raw], [check])]
 )
 UL_BUILD_INIT([raw])
@@ -1417,8 +1417,8 @@ AM_CONDITIONAL([BUILD_CHFN_CHSH], [test "x$build_chfn_chsh" = xyes])
 AM_CONDITIONAL([CHFN_CHSH_PASSWORD], [test "x$enable_chfn_chsh_password" = xyes])
 
 AC_ARG_ENABLE([chsh-only-listed],
-AS_HELP_STRING([--disable-chsh-only-listed], [chsh: allow shells not in /etc/shells]),
-[], enable_chsh_only_listed=yes
+  AS_HELP_STRING([--disable-chsh-only-listed], [chsh: allow shells not in /etc/shells]),
+  [], enable_chsh_only_listed=yes
 )
 
 AS_IF([test "x$enable_chsh_only_listed" = xyes], [
@@ -1814,14 +1814,14 @@ AC_MSG_RESULT([
 	prefix:            ${prefix}
 	exec prefix:       ${exec_prefix}
 
-        localstatedir:     ${localstatedir}
-	bindir:	           ${bindir}
+	localstatedir:     ${localstatedir}
+	bindir:            ${bindir}
 	sbindir:           ${sbindir}
 	libdir:            ${libdir}
 	includedir:        ${includedir}
-        usrbin_execdir:    ${usrbin_execdir}
-        usrsbin_execdir:   ${usrsbin_execdir}
-        usrlib_execdir:    ${usrlib_execdir}
+	usrbin_execdir:    ${usrbin_execdir}
+	usrsbin_execdir:   ${usrsbin_execdir}
+	usrlib_execdir:    ${usrlib_execdir}
 
 	compiler:          ${CC}
 	cflags:            ${CFLAGS}
-- 
1.7.0.4

