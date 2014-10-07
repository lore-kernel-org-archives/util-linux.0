Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48260 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbaJGJPw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Oct 2014 05:15:52 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so7129498wiv.17
        for <util-linux@vger.kernel.org>; Tue, 07 Oct 2014 02:15:51 -0700 (PDT)
From: =?UTF-8?q?No=C3=A9=20Rubinstein?= <nrubinstein@aldebaran.com>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?No=C3=A9=20Rubinstein?= <noe.rubinstein@gmail.com>
Subject: [RFC PATCH] hwclock: --offset: Use offset instead of writing clock
Date: Tue,  7 Oct 2014 11:15:36 +0200
Message-Id: <1412673336-13299-1-git-send-email-nrubinstein@aldebaran.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Noé Rubinstein <noe.rubinstein@gmail.com>

This option is useful for systems that have a working hardware clock, but do
not provide a way to write to it. Instead of setting the hardware clock, write
the difference between hardware and system clock to a file; when getting the
hardware clock, add the offset from this file to obtain the correct time.

I have not checked how well this interacts with the adjtime mechanism, so
this is an RFC patch.
---
 sys-utils/hwclock.8.in |  6 ++++
 sys-utils/hwclock.c    | 88 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index b11b45c..63fabda 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -113,6 +113,12 @@ not reset.
 .BR \-w , \ \-\-systohc
 Set the Hardware Clock to the current System Time.
 .TP
+.BR \-\-offset[=filename]
+This option is useful for systems that have a working hardware clock, but do
+not provide a way to write to it. Instead of setting the hardware clock, write
+the difference between hardware and system clock to a file; when getting the
+hardware clock, add the offset from this file to obtain the correct time.
+.TP
 .BR \-V , \ \-\-version
 Display version information and exit.
 .TP
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e780158..c7deab9 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -98,6 +98,7 @@ struct clock_ops *ur;
 #define MAX_DRIFT 2145.0
 
 const char *adj_file_name = NULL;
+const char *offset_file_name = NULL;
 
 struct adjtime {
 	/*
@@ -234,6 +235,35 @@ hw_clock_is_utc(const bool utc, const bool local_opt,
 	return ret;
 }
 
+static int read_offset(struct timeval *offset)
+{
+	FILE *f;
+	int rc;
+	f = fopen(offset_file_name, "r");
+	if (!f)
+		return -errno;
+
+	rc = fread(offset, sizeof(*offset), 1, f);
+	fclose(f);
+
+	return rc == 1 ? 0 : -EINVAL;
+}
+
+static int write_offset(struct timeval offset)
+{
+	FILE *f;
+	int rc;
+	f = fopen(offset_file_name, "w");
+	if (!f)
+		return -errno;
+
+	rc = fwrite(&offset, sizeof(offset), 1, f);
+	fclose(f);
+
+	return rc == 1 ? 0 : -EINVAL;
+}
+
+
 /*
  * Read the adjustment parameters out of the /etc/adjtime file.
  *
@@ -1290,6 +1320,8 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 	bool no_auth;
 	/* The time at which we read the Hardware Clock */
 	struct timeval read_time;
+	/* The offset between system time and hardware time */
+	struct timeval offset = {0};
 	/*
 	 * The Hardware Clock gives us a valid time, or at
 	 * least something close enough to fool mktime().
@@ -1320,6 +1352,11 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 		adjtime.dirty = FALSE;
 	}
 
+	if ((hctosys || show) && offset_file_name)
+	{
+		read_offset(&offset);
+	}
+
 	universal = hw_clock_is_utc(utc, local_opt, adjtime);
 
 	if ((set || systohc || adjust) &&
@@ -1328,7 +1365,8 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 		adjtime.dirty = TRUE;
 	}
 
-	if (show || adjust || hctosys || (!noadjfile && !systz && !predict)) {
+	if (show || adjust || hctosys || (!noadjfile && !systz && !predict) ||
+	    offset_file_name) {
 		/* data from HW-clock are required */
 		rc = synchronize_to_clock_tick();
 
@@ -1358,8 +1396,20 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 	}
 
 	if (show) {
-		display_time(hclock_valid, hclocktime,
+		display_time(hclock_valid, hclocktime + offset.tv_sec,
 			     time_diff(read_time, startup_time));
+	} else if (set && offset_file_name) {
+		if (!hclock_valid) {
+			printf(_("Hardware clock invalid, not writing offset.\n"));
+		} else {
+			offset.tv_sec = set_time - hclocktime;
+			rc = write_offset(offset);
+			if (rc) {
+				printf(_("Unable to write offset: %s."), strerror(-rc));
+				return rc;
+			}
+		}
+
 	} else if (set) {
 		set_hardware_clock_exact(set_time, startup_time,
 					 universal, testing);
@@ -1371,6 +1421,18 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 	} else if (adjust) {
 		do_adjustment(&adjtime, hclock_valid,
 			      hclocktime, read_time, universal, testing);
+	} else if (systohc && offset_file_name) {
+		if (!hclock_valid) {
+			printf(_("Hardware clock invalid, not writing offset.\n"));
+		} else {
+			gettimeofday(&offset, NULL);
+			offset.tv_sec -= hclocktime;
+			rc = write_offset(offset);
+			if (rc) {
+				printf(_("Unable to write offset: %s."), strerror(-rc));
+				return rc;
+			}
+		}
 	} else if (systohc) {
 		struct timeval nowtime, reftime;
 		/*
@@ -1390,6 +1452,17 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 					    reftime.tv_sec,
 					    hclock_valid, hclocktime, (double)
 					    read_time.tv_usec / 1E6);
+	} else if (hctosys && offset_file_name) {
+		if (!hclock_valid) {
+			printf(_("Hardware clock invalid, not setting time.\n"));
+		} else {
+			offset.tv_sec += hclocktime;
+			rc = settimeofday(&offset, NULL);
+			if (rc) {
+				printf(_("Unable to set system clock.\n"));
+				return rc;
+			}
+		}
 	} else if (hctosys) {
 		rc = set_system_clock(hclock_valid, hclocktime, testing);
 		if (rc) {
@@ -1547,6 +1620,7 @@ static void out_version(void)
 	printf(UTIL_LINUX_VERSION);
 }
 
+#define DEFAULT_OFFSET_FILE "/etc/time_offset"
 /*
  * usage - Output (error and) usage information
  *
@@ -1577,6 +1651,10 @@ static void usage(const char *fmt, ...)
 		"     --adjust         adjust the RTC to account for systematic drift since\n"
 		"                        the clock was last set or adjusted\n"), usageto);
 	fputs(_(" -c, --compare        periodically compare the system clock with the CMOS clock\n"), usageto);
+	fprintf(usageto,
+	      _("     --offset [file]  instead of setting the clock, write an offset to file.\n"
+	        "                      when reading the time, add this offset to the hardware time.\n"
+		"                         (default: %s)\n"), DEFAULT_OFFSET_FILE);
 #ifdef __linux__
 	fputs(_("     --getepoch       print out the kernel's hardware clock epoch value\n"
 		"     --setepoch       set the kernel's hardware clock epoch value to the \n"
@@ -1653,6 +1731,7 @@ int main(int argc, char **argv)
 	/* Long only options. */
 	enum {
 		OPT_ADJFILE = CHAR_MAX + 1,
+		OPT_OFFSET,
 		OPT_BADYEAR,
 		OPT_DATE,
 		OPT_DIRECTISA,
@@ -1698,6 +1777,7 @@ int main(int argc, char **argv)
 		{"test",	0, 0, OPT_TEST},
 		{"date",	1, 0, OPT_DATE},
 		{"epoch",	1, 0, OPT_EPOCH},
+		{"offset",	2, 0, OPT_OFFSET},
 #ifdef __linux__
 		{"rtc",		1, 0, 'f'},
 #endif
@@ -1837,6 +1917,10 @@ int main(int argc, char **argv)
 		case OPT_PREDICT_HC:
 			predict = TRUE;		/* --predict-hc */
 			break;
+		case OPT_OFFSET:
+			offset_file_name =	/* --offset */
+				optarg ? optarg : DEFAULT_OFFSET_FILE;
+			break;
 #ifdef __linux__
 		case 'f':
 			rtc_dev_name = optarg;	/* --rtc */
-- 
2.1.0

