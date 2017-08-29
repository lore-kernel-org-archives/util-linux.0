Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/3] hwclock: remove sysexits.h
To: Karel Zak <kzak@redhat.com>
References: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9f7af16d-d233-b618-e980-8e25e178ab77@gmx.com>
Date: Tue, 29 Aug 2017 12:33:14 -0400
MIME-Version: 1.0
In-Reply-To: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


sysexits.h was introduced in v2.11t prior to util-linux-ng, with the
HISTORY entry: * hwclock: minor polishing.

So there was no specific issue solved by adding it. Its use was never
documented so it should be safe to remove.

Also, fix return values being used for the exit status that were not
magic constants (portability issue).

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c |  5 ++--
 sys-utils/hwclock.8.in  |  8 ++++++
 sys-utils/hwclock.c     | 68 +++++++++++++++++--------------------------------
 3 files changed, 33 insertions(+), 48 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index c50011a..62e4329 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -6,7 +6,6 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <sysexits.h>
 #include <sys/ioctl.h>
 #include <sys/select.h>
 #include <sys/time.h>
@@ -149,7 +148,7 @@ static int open_rtc_or_exit(const struct hwclock_control *ctl)
 
 	if (rtc_fd < 0) {
 		warn(_("cannot open rtc device"));
-		hwclock_exit(ctl, EX_OSFILE);
+		hwclock_exit(ctl, EXIT_FAILURE);
 	}
 	return rtc_fd;
 }
@@ -356,7 +355,7 @@ static int set_hardware_clock_rtc(const struct hwclock_control *ctl,
 	if (rc == -1) {
 		warn(_("ioctl(%s) to %s to set the time failed"),
 			ioctlname, rtc_dev_name);
-		hwclock_exit(ctl, EX_IOERR);
+		hwclock_exit(ctl, EXIT_FAILURE);
 	}
 
 	if (ctl->debug)
diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 107e3f1..8bdc841 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -917,6 +917,14 @@ timescale. The zoneinfo database must be configured to use either posix
 or 'right', as described above, or by assigning a database path to the
 .SB TZDIR
 environment variable.
+.SH EXIT STATUS
+One of the following exit values will be returned:
+.TP
+.BR EXIT_SUCCESS " ('0' on POSIX systems)"
+Successful program execution.
+.TP
+.BR EXIT_FAILURE " ('1' on POSIX systems)"
+The operation failed or the command syntax was not valid.
 .SH ENVIRONMENT
 .TP
 .B TZ
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 31cd027..277953f 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -64,15 +64,11 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sysexits.h>
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <time.h>
 #include <unistd.h>
 
-#define OPTUTILS_EXIT_CODE EX_USAGE
-#define XALLOC_EXIT_CODE EX_OSERR
-
 #include "c.h"
 #include "closestream.h"
 #include "nls.h"
@@ -192,11 +188,8 @@ hw_clock_is_utc(const struct hwclock_control *ctl,
 /*
  * Read the adjustment parameters out of the /etc/adjtime file.
  *
- * Return them as the adjtime structure <*adjtime_p>. If there is no
- * /etc/adjtime file, return defaults. If values are missing from the file,
- * return defaults for them.
- *
- * return value 0 if all OK, !=0 otherwise.
+ * Return them as the adjtime structure <*adjtime_p>. Its defaults are
+ * initialized in main().
  */
 static int read_adjtime(const struct hwclock_control *ctl,
 			struct adjtime *adjtime_p)
@@ -207,12 +200,12 @@ static int read_adjtime(const struct hwclock_control *ctl,
 	char line3[81];		/* String: third line of adjtime file */
 
 	if (access(ctl->adj_file_name, R_OK) != 0)
-		return 0;
+		return EXIT_SUCCESS;
 
 	adjfile = fopen(ctl->adj_file_name, "r");	/* open file for reading */
 	if (adjfile == NULL) {
 		warn(_("cannot open %s"), ctl->adj_file_name);
-		return EX_OSFILE;
+		return EXIT_FAILURE;
 	}
 
 	if (!fgets(line1, sizeof(line1), adjfile))
@@ -255,7 +248,7 @@ static int read_adjtime(const struct hwclock_control *ctl,
 					       UTC) ? _("UTC") : _("unknown"));
 	}
 
-	return 0;
+	return EXIT_SUCCESS;
 }
 
 /*
@@ -654,10 +647,10 @@ set_system_clock(const struct hwclock_control *ctl,
 
 		if (rc) {
 			warn(_("settimeofday() failed"));
-			return  1;
+			return  EXIT_FAILURE;
 		}
 	}
-	return 0;
+	return EXIT_SUCCESS;
 }
 
 /*
@@ -900,17 +893,11 @@ static void determine_clock_access_method(const struct hwclock_control *ctl)
 			warnx(_("Use the --debug option to see the "
 				"details of our search for an access "
 				"method."));
-		hwclock_exit(ctl, EX_SOFTWARE);
+		hwclock_exit(ctl, EXIT_FAILURE);
 	}
 }
 
-/*
- * Do all the normal work of hwclock - read, set clock, etc.
- *
- * Issue output to stdout and error message to stderr where appropriate.
- *
- * Return rc == 0 if everything went OK, rc != 0 if not.
- */
+/* Do all the normal work of hwclock - read, set clock, etc. */
 static int
 manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 		 const struct timeval startup_time, struct adjtime *adjtime)
@@ -957,14 +944,14 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 			printf(_ ("Predicted RTC: %ld\n"), hclocktime.tv_sec);
 		}
 		display_time(hclocktime);
-		return 0;
+		return EXIT_SUCCESS;
 	}
 
 	if (ctl->systz)
 		return set_system_clock(ctl, startup_time);
 
 	if (ur->get_permissions())
-		return EX_NOPERM;
+		return EXIT_FAILURE;
 
 	/*
 	 * Read and drift correct RTC time; except for RTC set functions
@@ -980,13 +967,13 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 		 * operations are invalid without it.
 		 */
 		if (synchronize_to_clock_tick(ctl))
-			return EX_IOERR;
+			return EXIT_FAILURE;
 		read_hardware_clock(ctl, &hclock_valid, &hclocktime.tv_sec);
 		gettimeofday(&read_time, NULL);
 
 		if (!hclock_valid) {
 			warnx(_("RTC read returned an invalid value."));
-			return EX_IOERR;
+			return EXIT_FAILURE;
 		}
 		/*
 		 * Calculate and apply drift correction to the Hardware Clock
@@ -1035,7 +1022,7 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	}
 	if (!ctl->noadjfile)
 		save_adjtime(ctl, adjtime);
-	return 0;
+	return EXIT_SUCCESS;
 }
 
 /**
@@ -1118,15 +1105,6 @@ usage(const struct hwclock_control *ctl)
 	hwclock_exit(ctl, EXIT_SUCCESS);
 }
 
-/*
- * Returns:
- *  EX_USAGE: bad invocation
- *  EX_NOPERM: no permission
- *  EX_OSFILE: cannot open /dev/rtc or /etc/adjtime
- *  EX_IOERR: ioctl error getting or setting the time
- *  0: OK (or not)
- *  1: failure
- */
 int main(int argc, char **argv)
 {
 	struct hwclock_control ctl = { .show = 1 }; /* default op is show */
@@ -1211,7 +1189,7 @@ int main(int argc, char **argv)
 		 * have audit compiled in.
 		 */
 		warnx(_("Unable to connect to audit system"));
-		return EX_NOPERM;
+		return EXIT_FAILURE;
 	}
 #endif
 	setlocale(LC_ALL, "");
@@ -1322,13 +1300,13 @@ int main(int argc, char **argv)
 		case 'h':			/* --help */
 			usage(&ctl);
 		default:
-			errtryhelp(EX_USAGE);
+			errtryhelp(EXIT_FAILURE);
 		}
 	}
 
 	if (argc -= optind) {
 		warnx(_("%d too many arguments given"), argc);
-		errtryhelp(EX_USAGE);
+		errtryhelp(EXIT_FAILURE);
 	}
 
 	if (!ctl.adj_file_name)
@@ -1336,32 +1314,32 @@ int main(int argc, char **argv)
 
 	if (ctl.update && !ctl.set && !ctl.systohc) {
 		warnx(_("--update-drift requires --set or --systohc"));
-		hwclock_exit(&ctl, EX_USAGE);
+		hwclock_exit(&ctl, EXIT_FAILURE);
 	}
 
 	if (ctl.noadjfile && !ctl.utc && !ctl.local_opt) {
 		warnx(_("With --noadjfile, you must specify "
 			"either --utc or --localtime"));
-		hwclock_exit(&ctl, EX_USAGE);
+		hwclock_exit(&ctl, EXIT_FAILURE);
 	}
 
 	if (ctl.set || ctl.predict) {
 		if (!ctl.date_opt) {
 		warnx(_("--date is required for --set or --predict"));
-		hwclock_exit(&ctl, EX_USAGE);
+		hwclock_exit(&ctl, EXIT_FAILURE);
 		}
 		if (parse_date(&when, ctl.date_opt, NULL))
 			set_time = when.tv_sec;
 		else {
 			warnx(_("invalid date '%s'"), ctl.date_opt);
-			hwclock_exit(&ctl, EX_USAGE);
+			hwclock_exit(&ctl, EXIT_FAILURE);
 		}
 	}
 
 #if defined(__linux__) && defined(__alpha__)
 	if (ctl.getepoch || ctl.setepoch) {
 		manipulate_epoch(&ctl);
-		hwclock_exit(&ctl, EX_OK);
+		hwclock_exit(&ctl, EXIT_SUCCESS);
 	}
 #endif
 
@@ -1397,7 +1375,7 @@ hwclock_exit(const struct hwclock_control *ctl
 	if (ctl->hwaudit_on && !ctl->testing) {
 		audit_log_user_message(hwaudit_fd, AUDIT_USYS_CONFIG,
 				       "op=change-system-time", NULL, NULL, NULL,
-				       status ? 0 : 1);
+				       status);
 		close(hwaudit_fd);
 	}
 #endif
