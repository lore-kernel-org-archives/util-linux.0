Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:63758 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab3BJVds (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Feb 2013 16:33:48 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so4317612wge.22
        for <util-linux@vger.kernel.org>; Sun, 10 Feb 2013 13:33:47 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/3] build-sys: use AC_USE_SYSTEM_EXTENSIONS
Date: Sun, 10 Feb 2013 21:33:40 +0000
Message-Id: <1360532021-23647-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1360532021-23647-1-git-send-email-kerolasa@iki.fi>
References: <1360532021-23647-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The AC_GNU_SOURCE is obsolete.

Addresses: http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Obsolete-Macros.html#index-AC_005fGNU_005fSOURCE-2058
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 7ec8bd7..df0e9a9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -6,6 +6,9 @@ AC_PREREQ(2.60)
 
 AC_CONFIG_AUX_DIR(config)
 AC_CONFIG_MACRO_DIR([m4])
+dnl AC_USE_SYSTEM_EXTENSIONS must be called before any macros that run
+dnl the compiler (like AC_PROG_LIBTOOL) to avoid autoconf errors.
+AC_USE_SYSTEM_EXTENSIONS
 AM_INIT_AUTOMAKE([-Wall foreign 1.10 tar-pax dist-bzip2 no-dist-gzip dist-xz -Wno-portability subdir-objects])
 
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])],
@@ -87,7 +90,6 @@ AC_SUBST([usrlib_execdir])
 
 AM_PROG_CC_C_O
 AC_PROG_CC_STDC
-AC_GNU_SOURCE
 AC_CANONICAL_HOST
 AC_C_CONST
 AC_C_VOLATILE
-- 
1.8.1.3

