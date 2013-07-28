Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:63208 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3G1VLm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jul 2013 17:11:42 -0400
Received: by mail-wg0-f48.google.com with SMTP id f12so3617309wgh.3
        for <util-linux@vger.kernel.org>; Sun, 28 Jul 2013 14:11:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/7] build-sys: use backticks rather than $() for commands in configure
Date: Sun, 28 Jul 2013 22:11:20 +0100
Message-Id: <1375045881-11978-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
References: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The configure had both backticks and $() in use.  These command
susbstitutions are mutually interchangeable, so one should pick only one
form.  In this case backticks were favored because they are known with
greater range of shells, making the backticks to be more portable.

References: https://www.gnu.org/software/autoconf/manual/autoconf-2.67/html_node/Shell-Substitutions.html#index-g_t_0024_0028_0040var_007bcommands_007d_0029-1632
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6fae31e..7252e9b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1347,7 +1347,7 @@ AS_IF([test "x$enable_socket_activation" = xyes], [
 
 AC_ARG_WITH([systemdsystemunitdir],
   AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [directory for systemd service files]),
-  [], [with_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)])
+  [], [with_systemdsystemunitdir=`$PKG_CONFIG --variable=systemdsystemunitdir systemd`])
 
 AS_IF([test "x$with_systemdsystemunitdir" != "xno"], [
   AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])
@@ -1359,8 +1359,8 @@ AM_CONDITIONAL([HAVE_SYSTEMD], [test -n "$with_systemdsystemunitdir" -a "x$with_
 AC_ARG_WITH([bashcompletiondir],
   AS_HELP_STRING([--with-bashcompletiondir=DIR], [Bash completions directory]),
   [],
-  [AS_IF([$($PKG_CONFIG --exists bash-completion)], [
-    with_bashcompletiondir=$($PKG_CONFIG --variable=completionsdir bash-completion)
+  [AS_IF([`$PKG_CONFIG --exists bash-completion`], [
+    with_bashcompletiondir=`$PKG_CONFIG --variable=completionsdir bash-completion`
   ], [
     with_bashcompletiondir=${datadir}/bash-completion/completions
   ])
-- 
1.8.3.4

