Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/4] hwclock: --epoch presence test fails
To: Karel Zak <kzak@redhat.com>
References: <4a0f9283-7a08-a2c3-acc3-fb35ab51ec59@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <8b3cd606-d478-a623-704f-0e95dd8b58bd@gmx.com>
Date: Sun, 16 Jul 2017 13:49:43 -0400
MIME-Version: 1.0
In-Reply-To: <4a0f9283-7a08-a2c3-acc3-fb35ab51ec59@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


hwclock --setepoch --epoch 0
Will warn that the epoch option is required.

The --epoch presence test is made on its argument after it is
converted to an integer. This means any value it can be tested
for, can also be given as an input.

So make the conversion after the presence test, like the
--date option does.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c | 19 ++++++++-----------
 sys-utils/hwclock.8.in  |  3 +++
 sys-utils/hwclock.c     | 10 +++-------
 sys-utils/hwclock.h     |  2 +-
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index b39a970..9d3e5b9 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -431,15 +431,13 @@ int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch_p)
 int set_epoch_rtc(const struct hwclock_control *ctl)
 {
 	int rtc_fd;
+	unsigned long epoch;
 
-	if (ctl->epoch_option < 1900) {
-		/* kernel would not accept this epoch value
-		 *
-		 * Bad habit, deciding not to do what the user asks just
-		 * because one believes that the kernel might not like it.
-		 */
-		warnx(_("The epoch value may not be less than 1900.  "
-			"You requested %ld"), ctl->epoch_option);
+	epoch = strtoul(ctl->epoch_option, NULL, 10);
+
+	/* There were no RTC clocks before 1900. */
+	if (epoch < 1900 || epoch == ULONG_MAX) {
+		warnx(_("invalid epoch '%s'."), ctl->epoch_option);
 		return 1;
 	}
 
@@ -457,10 +455,9 @@ int set_epoch_rtc(const struct hwclock_control *ctl)
 
 	if (ctl->debug)
 		printf(_("setting epoch to %lu "
-			 "with RTC_EPOCH_SET ioctl to %s.\n"), ctl->epoch_option,
+			 "with RTC_EPOCH_SET ioctl to %s.\n"), epoch,
 		       rtc_dev_name);
-
-	if (ioctl(rtc_fd, RTC_EPOCH_SET, ctl->epoch_option) == -1) {
+	if (ioctl(rtc_fd, RTC_EPOCH_SET, epoch) == -1) {
 		if (errno == EINVAL)
 			warnx(_("The kernel device driver for %s "
 				"does not have the RTC_EPOCH_SET ioctl."),
diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index fa8a19a..b616e3f 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -305,6 +305,9 @@ methods fail.  See the
 .BI \-\-epoch= year
 This option is required when using the
 .BR \%\-\-setepoch \ function.
+.RI "The minimum " year
+value is 1900. The maximum is system dependent
+.RB ( ULONG_MAX\ -\ 1 ).
 .
 .TP
 .BR \-f , \ \-\-rtc=\fIfilename\fR
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index a3cd49a..445d736 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -78,7 +78,6 @@
 #include "nls.h"
 #include "optutils.h"
 #include "pathnames.h"
-#include "strutils.h"
 #include "hwclock.h"
 #include "timeutils.h"
 #include "env.h"
@@ -1179,13 +1178,13 @@ manipulate_epoch(const struct hwclock_control *ctl)
 			printf(_("Kernel is assuming an epoch value of %lu\n"),
 			       epoch);
 	} else if (ctl->setepoch) {
-		if (ctl->epoch_option == 0)
+		if (!ctl->epoch_option)
 			warnx(_
 			      ("To set the epoch value, you must use the 'epoch' "
 			       "option to tell to what value to set it."));
 		else if (ctl->testing)
 			printf(_
-			       ("Not setting the epoch to %lu - testing only.\n"),
+			       ("Not setting the epoch to %s - testing only.\n"),
 			       ctl->epoch_option);
 		else if (set_epoch_rtc(ctl))
 			printf(_
@@ -1328,8 +1327,6 @@ int main(int argc, char **argv)
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
-	strutils_set_exitcode(EX_USAGE);
-
 	/* Remember what time we were invoked */
 	gettimeofday(&startup_time, NULL);
 
@@ -1407,8 +1404,7 @@ int main(int argc, char **argv)
 			ctl.hwaudit_on = 1;
 			break;
 		case OPT_EPOCH:
-			ctl.epoch_option =	/* --epoch */
-			    strtoul_or_err(optarg, _("invalid epoch argument"));
+			ctl.epoch_option = optarg;	/* --epoch */
 			break;
 #endif
 		case OPT_NOADJFILE:
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index d527fe3..61be57a 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -20,7 +20,7 @@ struct hwclock_control {
 	char *date_opt;
 	char *adj_file_name;
 #if defined(__linux__) && defined(__alpha__)
-	unsigned long epoch_option;
+	char *epoch_option;
 #endif
 #ifdef __linux__
 	char *rtc_dev_name;
