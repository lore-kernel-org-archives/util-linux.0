Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f179.google.com ([209.85.223.179]:34865 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbbKSDDh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 Nov 2015 22:03:37 -0500
Received: by ioc74 with SMTP id 74so75496114ioc.2
        for <util-linux@vger.kernel.org>; Wed, 18 Nov 2015 19:03:37 -0800 (PST)
Received: from localhost ([2001:cc0:201e:102:3e97:eff:fea9:6aa7])
        by smtp.gmail.com with ESMTPSA id qb7sm2536709igb.8.2015.11.18.19.03.35
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 19:03:36 -0800 (PST)
From: "Casper Ti. Vector" <caspervector@gmail.com>
Message-Id: <9594740cc5f37047f0447904b539c3c54b278a3f.1447902109.git.CasperVector@gmail.com>
In-Reply-To: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
References: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
Date: Thu, 19 Nov 2015 10:52:14 +0800
Subject: [PATCH v2 1/2] ctrlaltdel: use reboot() provided by libc, assuming it
 is 1-adic.
To: util-linux@vger.kernel.org
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 configure.ac           | 6 ++++++
 sys-utils/ctrlaltdel.c | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6748dd2..6075f72 100644
--- a/configure.ac
+++ b/configure.ac
@@ -378,6 +378,7 @@ AC_CHECK_FUNCS([ioperm iopl], [have_io=yes])
 AC_CHECK_FUNCS([futimens], [have_futimens=yes])
 AC_CHECK_FUNCS([inotify_init1], [have_inotify_init1=yes])
 AC_CHECK_FUNCS([open_memstream], [have_open_memstream=yes],[have_open_memstream=no])
+AC_CHECK_FUNCS([reboot], [have_reboot=yes],[have_reboot=no])
 
 dnl lib/mononotic.c may require -lrt
 AC_CHECK_FUNCS([clock_gettime], [],
@@ -1420,6 +1421,11 @@ AM_CONDITIONAL([BUILD_DMESG], [test "x$build_dmesg" = xyes])
 
 UL_BUILD_INIT([ctrlaltdel], [check])
 UL_REQUIRES_LINUX([ctrlaltdel])
+dnl we assume reboot() to be the 1-argument variant, because even considering
+dnl widely used alternative C libraries like uclibc, dietlibc and musl,
+dnl reboot() with multiple arguments is yet only found in glibc versions
+dnl earlier than 2.x.
+UL_REQUIRES_HAVE([ctrlaltdel], [reboot])
 AM_CONDITIONAL([BUILD_CTRLALTDEL], [test "x$build_ctrlaltdel" = xyes])
 
 UL_BUILD_INIT([fsfreeze], [check])
diff --git a/sys-utils/ctrlaltdel.c b/sys-utils/ctrlaltdel.c
index 4388925..4a69584 100644
--- a/sys-utils/ctrlaltdel.c
+++ b/sys-utils/ctrlaltdel.c
@@ -10,13 +10,17 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
-#include "linux_reboot.h"
+#include <unistd.h>
+#include <sys/reboot.h>
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
 #include "pathnames.h"
 #include "path.h"
 
+#define LINUX_REBOOT_CMD_CAD_ON 0x89ABCDEF
+#define LINUX_REBOOT_CMD_CAD_OFF 0x00000000
+
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
@@ -67,7 +71,7 @@ static int set_cad(const char *arg)
 		warnx(_("unknown argument: %s"), arg);
 		return EXIT_FAILURE;
 	}
-	if (my_reboot(cmd) < 0) {
+	if (reboot(cmd) < 0) {
 		warnx("reboot");
 		return EXIT_FAILURE;
 	}
-- 
2.6.3

