Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46107 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab1JXSvJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Oct 2011 14:51:09 -0400
Received: by eye27 with SMTP id 27so5932864eye.19
        for <util-linux@vger.kernel.org>; Mon, 24 Oct 2011 11:51:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/2] prlimit: ensure necessary definitions are present
Date: Mon, 24 Oct 2011 20:50:44 +0200
Message-Id: <1319482245-5515-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

With Ubuntu linux-libc-dev 2.6.38-11.50 I got error mentioned
bellow. This patch fixes the issue.

prlimit.c:77:88: error: 'RLIMIT_RTTIME' undeclared here

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac        |    1 +
 sys-utils/prlimit.c |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 88aced9..873f1b2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -136,6 +136,7 @@ AC_CHECK_HEADERS(
 	rpcsvc/nfs_prot.h \
 	stdlib.h \
 	asm/io.h \
+	asm-generic/resource.h \
 	sys/disk.h \
 	sys/disklabel.h \
 	sys/ioctl.h \
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 74c7fc9..25949f1 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -26,6 +26,9 @@
 #include <assert.h>
 #include <unistd.h>
 #include <sys/resource.h>
+#ifdef HAVE_ASM_GENERIC_RESOURCE_H
+# include <asm-generic/resource.h>
+#endif
 
 #include "c.h"
 #include "nls.h"
@@ -33,6 +36,10 @@
 #include "xalloc.h"
 #include "strutils.h"
 
+#ifndef RLIMIT_RTTIME
+# define RLIMIT_RTTIME 15
+#endif
+
 enum {
 	AS,
 	CORE,
-- 
1.7.7

