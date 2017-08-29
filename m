Return-Path: elseifthen@gmx.com
Subject: [PATCH 2/3] hwclock: remove audit from control struct
To: Karel Zak <kzak@redhat.com>
References: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <484f55d0-ecaf-437c-cb70-e6a871f06878@gmx.com>
Date: Tue, 29 Aug 2017 12:34:07 -0400
MIME-Version: 1.0
In-Reply-To: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


hwaudit_on is only used in main() and hwclock_exit() and
that is unlikely to ever change.

Remove it from the control struct because it:
 * cleans up an ugly directive in hwclock_exit
 * removes an argument from usage() and hwclock_exit()
 * makes usage() comply with util-linux standards

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c |  4 ++--
 sys-utils/hwclock.c     | 46 +++++++++++++++++++++++-----------------------
 sys-utils/hwclock.h     |  3 +--
 3 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 62e4329..9d52e40 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -148,7 +148,7 @@ static int open_rtc_or_exit(const struct hwclock_control *ctl)
 
 	if (rtc_fd < 0) {
 		warn(_("cannot open rtc device"));
-		hwclock_exit(ctl, EXIT_FAILURE);
+		hwclock_exit(EXIT_FAILURE);
 	}
 	return rtc_fd;
 }
@@ -355,7 +355,7 @@ static int set_hardware_clock_rtc(const struct hwclock_control *ctl,
 	if (rc == -1) {
 		warn(_("ioctl(%s) to %s to set the time failed"),
 			ioctlname, rtc_dev_name);
-		hwclock_exit(ctl, EXIT_FAILURE);
+		hwclock_exit(EXIT_FAILURE);
 	}
 
 	if (ctl->debug)
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 277953f..6f868df 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -83,6 +83,7 @@
 #include <libaudit.h>
 static int hwaudit_fd = -1;
 #endif
+static int hwaudit_on;
 
 /* The struct that holds our hardware access routines */
 static struct clock_ops *ur;
@@ -893,7 +894,7 @@ static void determine_clock_access_method(const struct hwclock_control *ctl)
 			warnx(_("Use the --debug option to see the "
 				"details of our search for an access "
 				"method."));
-		hwclock_exit(ctl, EXIT_FAILURE);
+		hwclock_exit(EXIT_FAILURE);
 	}
 }
 
@@ -1058,7 +1059,7 @@ static void out_version(void)
 }
 
 static void __attribute__((__noreturn__))
-usage(const struct hwclock_control *ctl)
+usage(void)
 {
 	fputs(USAGE_HEADER, stdout);
 	printf(_(" %s [function] [option...]\n"), program_invocation_short_name);
@@ -1102,7 +1103,7 @@ usage(const struct hwclock_control *ctl)
 	fputs(USAGE_SEPARATOR, stdout);
 	printf(USAGE_HELP_OPTIONS(22));
 	printf(USAGE_MAN_TAIL("hwclock(8)"));
-	hwclock_exit(ctl, EXIT_SUCCESS);
+	hwclock_exit(EXIT_SUCCESS);
 }
 
 int main(int argc, char **argv)
@@ -1217,7 +1218,7 @@ int main(int argc, char **argv)
 		case 'a':
 			ctl.adjust = 1;
 			ctl.show = 0;
-			ctl.hwaudit_on = 1;
+			hwaudit_on = 1;
 			break;
 		case 'l':
 			ctl.local_opt = 1;	/* --localtime */
@@ -1228,7 +1229,7 @@ int main(int argc, char **argv)
 		case 's':
 			ctl.hctosys = 1;
 			ctl.show = 0;
-			ctl.hwaudit_on = 1;
+			hwaudit_on = 1;
 			break;
 		case 'u':
 			ctl.utc = 1;
@@ -1236,12 +1237,12 @@ int main(int argc, char **argv)
 		case 'w':
 			ctl.systohc = 1;
 			ctl.show = 0;
-			ctl.hwaudit_on = 1;
+			hwaudit_on = 1;
 			break;
 		case OPT_SET:
 			ctl.set = 1;
 			ctl.show = 0;
-			ctl.hwaudit_on = 1;
+			hwaudit_on = 1;
 			break;
 #if defined(__linux__) && defined(__alpha__)
 		case OPT_GETEPOCH:
@@ -1251,7 +1252,7 @@ int main(int argc, char **argv)
 		case OPT_SETEPOCH:
 			ctl.setepoch = 1;
 			ctl.show = 0;
-			ctl.hwaudit_on = 1;
+			hwaudit_on = 1;
 			break;
 		case OPT_EPOCH:
 			ctl.epoch_option = optarg;	/* --epoch */
@@ -1275,7 +1276,7 @@ int main(int argc, char **argv)
 		case OPT_SYSTZ:
 			ctl.systz = 1;		/* --systz */
 			ctl.show = 0;
-			ctl.hwaudit_on = 1;
+			hwaudit_on = 1;
 			break;
 		case OPT_PREDICT:
 			ctl.predict = 1;	/* --predict */
@@ -1298,12 +1299,15 @@ int main(int argc, char **argv)
 			out_version();
 			return 0;
 		case 'h':			/* --help */
-			usage(&ctl);
+			usage();
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
 	}
 
+	if (ctl.testing)
+			hwaudit_on = 0;
+
 	if (argc -= optind) {
 		warnx(_("%d too many arguments given"), argc);
 		errtryhelp(EXIT_FAILURE);
@@ -1314,32 +1318,32 @@ int main(int argc, char **argv)
 
 	if (ctl.update && !ctl.set && !ctl.systohc) {
 		warnx(_("--update-drift requires --set or --systohc"));
-		hwclock_exit(&ctl, EXIT_FAILURE);
+		hwclock_exit(EXIT_FAILURE);
 	}
 
 	if (ctl.noadjfile && !ctl.utc && !ctl.local_opt) {
 		warnx(_("With --noadjfile, you must specify "
 			"either --utc or --localtime"));
-		hwclock_exit(&ctl, EXIT_FAILURE);
+		hwclock_exit(EXIT_FAILURE);
 	}
 
 	if (ctl.set || ctl.predict) {
 		if (!ctl.date_opt) {
 		warnx(_("--date is required for --set or --predict"));
-		hwclock_exit(&ctl, EXIT_FAILURE);
+		hwclock_exit(EXIT_FAILURE);
 		}
 		if (parse_date(&when, ctl.date_opt, NULL))
 			set_time = when.tv_sec;
 		else {
 			warnx(_("invalid date '%s'"), ctl.date_opt);
-			hwclock_exit(&ctl, EXIT_FAILURE);
+			hwclock_exit(EXIT_FAILURE);
 		}
 	}
 
 #if defined(__linux__) && defined(__alpha__)
 	if (ctl.getepoch || ctl.setepoch) {
 		manipulate_epoch(&ctl);
-		hwclock_exit(&ctl, EXIT_SUCCESS);
+		hwclock_exit(EXIT_SUCCESS);
 	}
 #endif
 
@@ -1354,25 +1358,21 @@ int main(int argc, char **argv)
 
 	if (!ctl.noadjfile && !(ctl.systz && (ctl.utc || ctl.local_opt))) {
 		if ((rc = read_adjtime(&ctl, &adjtime)) != 0)
-			hwclock_exit(&ctl, rc);
+			hwclock_exit(rc);
 	} else
 		/* Avoid writing adjtime file if we don't have to. */
 		adjtime.dirty = FALSE;
 	ctl.universal = hw_clock_is_utc(&ctl, adjtime);
 	rc = manipulate_clock(&ctl, set_time, startup_time, &adjtime);
-	hwclock_exit(&ctl, rc);
+	hwclock_exit(rc);
 	return rc;		/* Not reached */
 }
 
 void
-hwclock_exit(const struct hwclock_control *ctl
-#ifndef HAVE_LIBAUDIT
-	     __attribute__((__unused__))
-#endif
-	     , int status)
+hwclock_exit(int status)
 {
 #ifdef HAVE_LIBAUDIT
-	if (ctl->hwaudit_on && !ctl->testing) {
+	if (hwaudit_on) {
 		audit_log_user_message(hwaudit_fd, AUDIT_USYS_CONFIG,
 				       "op=change-system-time", NULL, NULL, NULL,
 				       status);
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 6943d8d..013a7a3 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -20,7 +20,6 @@ struct hwclock_control {
 #endif
 	unsigned int debug;
 	unsigned int
-		hwaudit_on:1,
 		adjust:1,
 		show:1,
 		hctosys:1,
@@ -66,6 +65,6 @@ extern int set_epoch_rtc(const struct hwclock_control *ctl);
 #endif
 
 extern void __attribute__((__noreturn__))
-hwclock_exit(const struct hwclock_control *ctl, int status);
+hwclock_exit(int status);
 
 #endif				/* HWCLOCK_CLOCK_H */
