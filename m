Return-Path: elseifthen@gmx.com
Subject: [PATCH 5/5] hwclock: remove custom errno string
To: Karel Zak <kzak@redhat.com>
References: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <1cede91e-89c0-84a6-3440-ba2ef65c9330@gmx.com>
Date: Mon, 31 Jul 2017 19:52:50 -0400
MIME-Version: 1.0
In-Reply-To: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Custom errno messages are unnecessary and problematic for translators.

hwclock --directisa
hwclock: iopl() port access failed: Operation not permitted
hwclock: root privileges may be required

The custom errno message is misleading. We do not know what
the system permissions are set to. The default errno string is
correct, and enough.

Patched:
hwclock --directisa
hwclock: iopl() port access failed: Operation not permitted

root@:~# hwclock --directisa -D
Using direct ISA access to the clock
2017-07-24 14:49:17.782716-0400

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-cmos.c | 6 +-----
 sys-utils/hwclock.h      | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index 6227b94..cdbc88b 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -45,7 +45,6 @@
  *   tm_isdst	>0: yes, 0: no, <0: unknown
  */
 
-#include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <string.h>
@@ -390,12 +389,9 @@ static int get_permissions_cmos(void)
 	if (rc == IOPL_NOT_IMPLEMENTED) {
 		warnx(_("ISA port access is not implemented"));
 	} else if (rc != 0) {
-		rc = errno;
 		warn(_("iopl() port access failed"));
-		if (rc == EPERM && geteuid())
-			warnx(_("root privileges may be required"));
 	}
-	return rc ? 1 : 0;
+	return rc;
 }
 
 static struct clock_ops cmos_interface = {
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index a1ef80c..8843501 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -1,7 +1,6 @@
 #ifndef HWCLOCK_CLOCK_H
 #define HWCLOCK_CLOCK_H
 
-#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
