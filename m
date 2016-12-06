Return-Path: util-linux-owner@vger.kernel.org
Received: from skprod2.natinst.com ([130.164.80.23]:47015 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753581AbcLFQG1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Dec 2016 11:06:27 -0500
Received: from us-aus-exch2.ni.corp.natinst.com (us-aus-exch2.ni.corp.natinst.com [130.164.68.12])
        by us-aus-skprod2.natinst.com (8.15.0.59/8.15.0.59) with ESMTPS id uB6G6Qlj031464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Tue, 6 Dec 2016 10:06:26 -0600
From: Marian Vomir <marian.vomir@ni.com>
To: <util-linux@vger.kernel.org>
Subject: [PATCH 2/2] sys-utils/hwclock: make hwclock check for CAP_SYS_TIME capability
Date: Tue, 6 Dec 2016 20:06:20 +0200
Message-ID: <1481047580-28284-2-git-send-email-marian.vomir@ni.com>
In-Reply-To: <1481047580-28284-1-git-send-email-marian.vomir@ni.com>
References: <1481047580-28284-1-git-send-email-marian.vomir@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

hwclock now checks if the capability to modify the clock (CAP_SYS_TIME) is set.
This allows the clock to be changed by unprivileged processes which have this capability.
---
 sys-utils/Makemodule.am |  2 +-
 sys-utils/hwclock.c     | 59 +++++++++++++++++++++++++++++++++++--------------
 2 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index f306e65..d40a4d9 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -412,5 +412,5 @@ if BUILD_SETPRIV
 usrbin_exec_PROGRAMS += setpriv
 dist_man_MANS += sys-utils/setpriv.1
 setpriv_SOURCES = sys-utils/setpriv.c
-setpriv_LDADD = $(LDADD) -lcap-ng libcommon.la
+setpriv_LDADD = $(LDADD) -lcap-ng -lcap libcommon.la
 endif
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 880ba78..20ac6bf 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -66,6 +66,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sysexits.h>
+#include <sys/capability.h>
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <time.h>
@@ -1904,24 +1905,48 @@ int main(int argc, char **argv)
 	      | setepoch | predict | compare | get))
 		show = 1;	/* default to show */
 
-	if (getuid() == 0)
-		permitted = TRUE;
-	else {
+	permitted = TRUE;
+	if (getuid() != 0) {
 		/* program is designed to run setuid (in some situations) */
-		if ((set || systohc || adjust) && !testing) {
-			warnx(_("Sorry, only the superuser can change "
-				"the Hardware Clock."));
-			permitted = FALSE;
-		} else if ((systz || hctosys) && !testing) {
-			warnx(_("Sorry, only the superuser can change "
-				"the System Clock."));
-			permitted = FALSE;
-		} else if (setepoch && !testing) {
-			warnx(_("Sorry, only the superuser can change the "
-				"Hardware Clock epoch in the kernel."));
-			permitted = FALSE;
-		} else
-			permitted = TRUE;
+		if (!testing &&
+		    (set || systohc || adjust || systz || hctosys || setepoch)) {
+			cap_t cap;
+			cap_flag_value_t flag_val;
+			cap_value_t val;
+
+			cap = cap_get_proc();
+			if (cap == NULL) {
+				warnx(_("cap_get_proc failed"));
+				permitted = FALSE;
+			}
+
+			if (cap_from_name("cap_sys_time", &val) == -1) {
+				switch (errno) {
+					case EINVAL:
+						warnx(_("cap_from_name: invalid capability: 'cap_sys_time'"));
+					break;
+					case ENOMEM:
+						warnx(_("cap_from_name: out of memory"));
+					break;
+					default:
+						warnx(_("cap_from_name: unknown error"));
+					break;
+				}
+				permitted = FALSE;
+			}
+
+			if (cap_get_flag(cap, val, CAP_EFFECTIVE, &flag_val) == -1) {
+				warnx(_("cap_get_flag: invalid capability"));
+				permitted = FALSE;
+			}
+
+			if (flag_val != CAP_SET) {
+				warnx(_("Non-root cannot run hwclock without capability CAP_SYS_TIME set"));
+				permitted = FALSE;
+			}
+
+			cap_free(cap);
+		}
 	}
 
 	if (!permitted)
-- 
2.7.4

