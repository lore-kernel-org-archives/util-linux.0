Return-Path: elseifthen@gmx.com
Subject: [PATCH 4/5] hwclock: improve audit control
To: Karel Zak <kzak@redhat.com>
References: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <b6620933-96c1-fc35-93dc-4bed1923bb7d@gmx.com>
Date: Tue, 18 Apr 2017 23:07:58 -0400
MIME-Version: 1.0
In-Reply-To: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Move audit control to option parsing. This fixes non-alpha build
error and cleans up an unruly 'if' statement.

Having audit control in option parsing may also draw awareness to
the audit system when adding new functions, which could easily be
overlooked otherwise.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 17 ++++++-----------
 sys-utils/hwclock.h |  2 --
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index bb3a9d8..a98f4e3 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1395,6 +1395,7 @@ int main(int argc, char **argv)
 		case 'a':
 			ctl.adjust = 1;
 			ctl.show = 0;
+			ctl.hwaudit_on = 1;
 			break;
 		case 'r':
 			ctl.show = 1;
@@ -1402,6 +1403,7 @@ int main(int argc, char **argv)
 		case 's':
 			ctl.hctosys = 1;
 			ctl.show = 0;
+			ctl.hwaudit_on = 1;
 			break;
 		case 'u':
 			ctl.utc = 1;
@@ -1409,10 +1411,12 @@ int main(int argc, char **argv)
 		case 'w':
 			ctl.systohc = 1;
 			ctl.show = 0;
+			ctl.hwaudit_on = 1;
 			break;
 		case OPT_SET:
 			ctl.set = 1;
 			ctl.show = 0;
+			ctl.hwaudit_on = 1;
 			break;
 #if defined(__linux__) && defined(__alpha__)
 		case OPT_GETEPOCH:
@@ -1422,6 +1426,7 @@ int main(int argc, char **argv)
 		case OPT_SETEPOCH:
 			ctl.setepoch = 1;
 			ctl.show = 0;
+			ctl.hwaudit_on = 1;
 			break;
 		case OPT_EPOCH:
 			ctl.epoch_option =	/* --epoch */
@@ -1480,16 +1485,6 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
-#ifdef HAVE_LIBAUDIT
-	if (!ctl.testing) {
-		if (ctl.adjust || ctl.hctosys || ctl.systohc || ctl.set
-# if defined(__linux__) && defined(__alpha__)
-		    || ctl.setepoch
-# endif
-		    )
-			ctl.hwaudit_on = 1;
-	}
-#endif
 	if (argc > 0) {
 		warnx(_("%d too many arguments given"), argc);
 		errtryhelp(EXIT_FAILURE);
@@ -1550,7 +1545,7 @@ hwclock_exit(const struct hwclock_control *ctl
 	     , int status)
 {
 #ifdef HAVE_LIBAUDIT
-	if (ctl->hwaudit_on) {
+	if (ctl->hwaudit_on && !ctl->testing) {
 		audit_log_user_message(hwaudit_fd, AUDIT_USYS_CONFIG,
 				       "op=change-system-time", NULL, NULL, NULL,
 				       status ? 0 : 1);
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 7830ef6..7d2cc45 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -26,9 +26,7 @@ struct hwclock_control {
 #endif
 	unsigned int debug;
 	unsigned int
-#ifdef HAVE_LIBAUDIT
 		hwaudit_on:1,
-#endif
 		adjust:1,
 		show:1,
 		hctosys:1,
