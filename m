Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759222AbdDSDDT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Apr 2017 23:03:19 -0400
Subject: [PATCH 2/5] hwclock: make epoch functions alpha only
To: Karel Zak <kzak@redhat.com>
References: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <3d5a56db-4eba-0d46-ece0-d25706e5d8a2@gmx.com>
Date: Tue, 18 Apr 2017 23:03:07 -0400
MIME-Version: 1.0
In-Reply-To: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


It's been 19.1315 years since the comment below was written and the kernel
has actually gone further away from allowing an RTC epoch on ISA machines.

/*
 * Maintenance note: This should work on non-Alpha machines, but the
 * evidence today (98.03.04) indicates that the kernel only keeps the epoch
 * value on Alphas. If that is ever fixed, this function should be changed.
 */

The current behavior is to accept the epoch options on ISA machines
only to print a lengthy message explaining that you cannot use them.

This patch removes that behavior, making the epoch functions truly Alpha
only, as the man-page states that they are.

* sys-utils/hwclock.c: make epoch function alpha only.
* sys-utils/hwclock.h: same.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 61 ++++++++++++++++++++---------------------------------
 sys-utils/hwclock.h |  8 +++++--
 2 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 10436f2..0c58795 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1162,28 +1162,11 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	return 0;
 }
 
-/*
- * Get or set the Hardware Clock epoch value in the kernel, as appropriate.
- * <getepoch>, <setepoch>, and <epoch> are hwclock invocation options.
- *
- * <epoch> == -1 if the user did not specify an "epoch" option.
- */
-#ifdef __linux__
-/*
- * Maintenance note: This should work on non-Alpha machines, but the
- * evidence today (98.03.04) indicates that the kernel only keeps the epoch
- * value on Alphas. If that is ever fixed, this function should be changed.
+/**
+ * Get or set the kernel RTC driver's epoch on Alpha machines.
+ * ISA machines are hard coded for 1900.
  */
-# ifndef __alpha__
-static void
-manipulate_epoch(const struct hwclock_control *ctl __attribute__((__unused__)))
-{
-	warnx(_("The kernel keeps an epoch value for the Hardware Clock "
-		"only on an Alpha machine.\nThis copy of hwclock was built for "
-		"a machine other than Alpha\n(and thus is presumably not running "
-		"on an Alpha now).  No action taken."));
-}
-# else
+#if defined(__linux__) && defined(__alpha__)
 static void
 manipulate_epoch(const struct hwclock_control *ctl)
 {
@@ -1210,8 +1193,7 @@ manipulate_epoch(const struct hwclock_control *ctl)
 			       ("Unable to set the epoch value in the kernel.\n"));
 	}
 }
-# endif		/* __alpha__ */
-#endif		/* __linux__ */
+#endif		/* __linux__ __alpha__ */
 
 static void out_version(void)
 {
@@ -1251,7 +1233,7 @@ static void usage(const struct hwclock_control *ctl, const char *fmt, ...)
 		"     --systz          set the system time based on the current timezone\n"
 		"     --adjust         adjust the RTC to account for systematic drift since\n"
 		"                        the clock was last set or adjusted\n"), usageto);
-#ifdef __linux__
+#if defined(__linux__) && defined(__alpha__)
 	fputs(_("     --getepoch       print out the kernel's hardware clock epoch value\n"
 		"     --setepoch       set the kernel's hardware clock epoch value to the \n"
 		"                        value given with --epoch\n"), usageto);
@@ -1267,9 +1249,10 @@ static void usage(const struct hwclock_control *ctl, const char *fmt, ...)
 #endif
 	fprintf(usageto, _(
 		"     --directisa      access the ISA bus directly instead of %s\n"
-		"     --date <time>    specifies the time to which to set the hardware clock\n"
-		"     --epoch <year>   specifies the year which is the beginning of the\n"
-		"                        hardware clock's epoch value\n"), _PATH_RTC_DEV);
+		"     --date <time>    specifies the time to which to set the hardware clock\n"), _PATH_RTC_DEV);
+#if defined(__linux__) && defined(__alpha__)
+	fputs(_("     --epoch <year>   specifies the hardware clock's epoch value\n"), usageto);
+#endif
 	fprintf(usageto, _(
 		"     --update-drift   update drift factor in %1$s (requires\n"
 		"                        --set or --systohc)\n"
@@ -1340,16 +1323,16 @@ int main(int argc, char **argv)
 		{ "systohc",      no_argument,       NULL, 'w'            },
 		{ "debug",        no_argument,       NULL, 'D'            },
 		{ "set",          no_argument,       NULL, OPT_SET        },
-#ifdef __linux__
+#if defined(__linux__) && defined(__alpha__)
 		{ "getepoch",     no_argument,       NULL, OPT_GETEPOCH   },
 		{ "setepoch",     no_argument,       NULL, OPT_SETEPOCH   },
+		{ "epoch",        required_argument, NULL, OPT_EPOCH      },
 #endif
 		{ "noadjfile",    no_argument,       NULL, OPT_NOADJFILE  },
 		{ "localtime",    no_argument,       NULL, OPT_LOCALTIME  },
 		{ "directisa",    no_argument,       NULL, OPT_DIRECTISA  },
 		{ "test",         no_argument,       NULL, OPT_TEST       },
 		{ "date",         required_argument, NULL, OPT_DATE       },
-		{ "epoch",        required_argument, NULL, OPT_EPOCH      },
 #ifdef __linux__
 		{ "rtc",          required_argument, NULL, 'f'            },
 #endif
@@ -1431,7 +1414,7 @@ int main(int argc, char **argv)
 			ctl.set = 1;
 			ctl.show = 0;
 			break;
-#ifdef __linux__
+#if defined(__linux__) && defined(__alpha__)
 		case OPT_GETEPOCH:
 			ctl.getepoch = 1;
 			ctl.show = 0;
@@ -1440,6 +1423,10 @@ int main(int argc, char **argv)
 			ctl.setepoch = 1;
 			ctl.show = 0;
 			break;
+		case OPT_EPOCH:
+			ctl.epoch_option =	/* --epoch */
+			    strtoul_or_err(optarg, _("invalid epoch argument"));
+			break;
 #endif
 		case OPT_NOADJFILE:
 			ctl.noadjfile = 1;
@@ -1456,10 +1443,6 @@ int main(int argc, char **argv)
 		case OPT_DATE:
 			ctl.date_opt = optarg;	/* --date */
 			break;
-		case OPT_EPOCH:
-			ctl.epoch_option =	/* --epoch */
-			    strtoul_or_err(optarg, _("invalid epoch argument"));
-			break;
 		case OPT_ADJFILE:
 			ctl.adj_file_name = optarg;	/* --adjfile */
 			break;
@@ -1499,10 +1482,12 @@ int main(int argc, char **argv)
 
 #ifdef HAVE_LIBAUDIT
 	if (!ctl.testing) {
-		if (ctl.adjust || ctl.hctosys || ctl.systohc ||
-		    ctl.set || ctl.setepoch) {
+		if (ctl.adjust || ctl.hctosys || ctl.systohc || ctl.set
+# if defined(__linux__) && defined(__alpha__)
+		    || ctl.setepoch
+# endif
+		    )
 			ctl.hwaudit_on = 1;
-		}
 	}
 #endif
 	if (argc > 0) {
@@ -1528,7 +1513,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-#ifdef __linux__
+#if defined(__linux__) && defined(__alpha__)
 	if (ctl.getepoch || ctl.setepoch) {
 		manipulate_epoch(&ctl);
 		hwclock_exit(&ctl, EX_OK);
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 37e8173..7830ef6 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -17,8 +17,10 @@ enum {
 
 struct hwclock_control {
 	char *date_opt;
-	unsigned long epoch_option;
 	char *adj_file_name;
+#if defined(__linux__) && defined(__alpha__)
+	unsigned long epoch_option;
+#endif
 #ifdef __linux__
 	char *rtc_dev_name;
 #endif
@@ -32,7 +34,7 @@ struct hwclock_control {
 		hctosys:1,
 		utc:1,
 		systohc:1,
-#ifdef __linux__
+#if defined(__linux__) && defined(__alpha__)
 		getepoch:1,
 		setepoch:1,
 #endif
@@ -67,8 +69,10 @@ extern unsigned long epoch_option;
 extern double time_diff(struct timeval subtrahend, struct timeval subtractor);
 
 /* rtc.c */
+#if defined(__linux__) && defined(__alpha__)
 extern int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch);
 extern int set_epoch_rtc(const struct hwclock_control *ctl);
+#endif
 
 extern void hwclock_exit(const struct hwclock_control *ctl, int status);
 
