Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:45446
        "EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbdG3Rw1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 30 Jul 2017 13:52:27 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] whereis: include native multiarch path in lib search paths
Date: Sun, 30 Jul 2017 19:52:17 +0200
Message-Id: <1501437137-30759-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This includes atleast the native multiarch path in the paths to search.
(Maybe also other multiarch paths should also be searched? But atleast
this is a first step.)

Before this change (on Debian):
$ whereis libc
libc: /usr/share/man/man7/libc.7.gz

After this change:
$ whereis libc
libc: /usr/lib/x86_64-linux-gnu/libc.so /usr/lib/x86_64-linux-gnu/libc.a /usr/share/man/man7/libc.7.gz

Addresses: https://bugs.debian.org/856968
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 configure.ac         | 5 +++++
 misc-utils/whereis.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/configure.ac b/configure.ac
index 38b968878..dc71faa00 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1490,6 +1490,11 @@ AM_CONDITIONAL([BUILD_MCOOKIE], [test "x$build_mcookie" = xyes])
 UL_BUILD_INIT([namei], [yes])
 AM_CONDITIONAL([BUILD_NAMEI], [test "x$build_namei" = xyes])
 
+matriplet="$($CC -print-multiarch 2>/dev/null || true)"
+if test "x$matriplet" != "x"; then
+  AC_DEFINE_UNQUOTED([MULTIARCHTRIPLET], ["$matriplet"],
+  ["Multi-arch triplet for whereis library search path"])
+fi
 UL_BUILD_INIT([whereis], [yes])
 AM_CONDITIONAL([BUILD_WHEREIS], [test "x$build_whereis" = xyes])
 
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index bac158d46..caa155ca3 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -96,6 +96,11 @@ struct wh_dirlist {
 static const char *bindirs[] = {
 	"/usr/bin",
 	"/usr/sbin",
+#if defined(MULTIARCHTRIPLET)
+	"/lib/" MULTIARCHTRIPLET,
+	"/usr/lib/" MULTIARCHTRIPLET,
+	"/usr/local/lib/" MULTIARCHTRIPLET,
+#endif
 	"/usr/lib",
 	"/usr/lib64",
 	"/bin",
-- 
2.11.0

