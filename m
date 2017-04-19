Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/5] hwclock: improve default function handling
To: Karel Zak <kzak@redhat.com>
References: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <660056f5-eb57-cc74-95b1-0caacd0a3868@gmx.com>
Date: Tue, 18 Apr 2017 22:59:33 -0400
MIME-Version: 1.0
In-Reply-To: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Removes long default function test. Instead handle the
default when the options are parsed.

Also fixes the non-linux build failure reported by Rudi:
http://marc.info/?l=util-linux-ng&m=149189833115871

Reported-by: Ruediger Meier <ruediger.meier@ga-group.nl>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index a99eb6d..10436f2 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1301,7 +1301,7 @@ static void usage(const struct hwclock_control *ctl, const char *fmt, ...)
  */
 int main(int argc, char **argv)
 {
-	struct hwclock_control ctl = { NULL };
+	struct hwclock_control ctl = { .show = 1 }; /* default op is show */
 	struct timeval startup_time;
 	struct adjtime adjtime = { 0 };
 	struct timespec when = { 0 };
@@ -1411,28 +1411,34 @@ int main(int argc, char **argv)
 			break;
 		case 'a':
 			ctl.adjust = 1;
+			ctl.show = 0;
 			break;
 		case 'r':
 			ctl.show = 1;
 			break;
 		case 's':
 			ctl.hctosys = 1;
+			ctl.show = 0;
 			break;
 		case 'u':
 			ctl.utc = 1;
 			break;
 		case 'w':
 			ctl.systohc = 1;
+			ctl.show = 0;
 			break;
 		case OPT_SET:
 			ctl.set = 1;
+			ctl.show = 0;
 			break;
 #ifdef __linux__
 		case OPT_GETEPOCH:
 			ctl.getepoch = 1;
+			ctl.show = 0;
 			break;
 		case OPT_SETEPOCH:
 			ctl.setepoch = 1;
+			ctl.show = 0;
 			break;
 #endif
 		case OPT_NOADJFILE:
@@ -1459,12 +1465,15 @@ int main(int argc, char **argv)
 			break;
 		case OPT_SYSTZ:
 			ctl.systz = 1;		/* --systz */
+			ctl.show = 0;
 			break;
 		case OPT_PREDICT_HC:
 			ctl.predict = 1;	/* --predict-hc */
+			ctl.show = 0;
 			break;
 		case OPT_GET:
 			ctl.get = 1;		/* --get */
+			ctl.show = 0;
 			break;
 		case OPT_UPDATE:
 			ctl.update = 1;		/* --update-drift */
@@ -1519,11 +1528,6 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (!(ctl.show | ctl.set | ctl.systohc | ctl.hctosys |
-	     ctl.systz | ctl.adjust | ctl.getepoch | ctl.setepoch |
-	     ctl.predict | ctl.get))
-		ctl.show = 1;	/* default to show */
-
 #ifdef __linux__
 	if (ctl.getepoch || ctl.setepoch) {
 		manipulate_epoch(&ctl);
