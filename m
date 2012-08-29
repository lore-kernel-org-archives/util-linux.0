Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42378 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab2H2QkG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Aug 2012 12:40:06 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7TGe6x5017832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 29 Aug 2012 12:40:06 -0400
Received: from [10.34.4.237] (unused-4-237.brq.redhat.com [10.34.4.237])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q7TGe4H3008492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Wed, 29 Aug 2012 12:40:05 -0400
Message-ID: <503E45E3.8010001@redhat.com>
Date: Wed, 29 Aug 2012 18:40:03 +0200
From: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [RFE] hwclock: new --compare option
Content-Type: multipart/mixed;
 boundary="------------030901060009000604000602"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030901060009000604000602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
Here's my patch and proposal to add a compare option to hwclock.
The idea is that it would perform similarly to adjtimex --compare.

have a nice day,
  Ondrej.

--------------030901060009000604000602
Content-Type: text/plain; charset=UTF-8;
 name="DIFF"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="DIFF"

>From 3a5494a1c32e2698de0508cec70149bed8149032 Mon Sep 17 00:00:00 2001
From: Ondrej Oprala <ooprala@redhat.com>
Date: Wed, 29 Aug 2012 18:11:15 +0200
Subject: [PATCH] hwclock: add a new --compare option

The new option imitates adjtimex -c functionality and outputs
the drift in 10 second intervals.
---
 sys-utils/hwclock.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e25546d..407ac8a 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1337,6 +1337,61 @@ manipulate_epoch(const bool getepoch,
 # endif		/* __alpha__ */
 #endif		/* __linux__ */
 
+/*
+ * Compare the system and CMOS time and output the drift
+ * in 10 second intervals.
+ */
+static int compare_clock (const bool utc, const bool local_opt)
+{
+	struct tm tm;
+	struct timeval tv;
+	struct adjtime adjtime;
+	double time1_sys, time2_sys;
+	time_t time1_hw, time2_hw;
+	bool hclock_valid = FALSE;
+
+	/* dummy call for increased precision */
+	gettimeofday(&tv, NULL);
+
+	if (read_adjtime(&adjtime))
+		return 1;
+	bool universal = hw_clock_is_utc(utc, local_opt, adjtime);
+  ur->get_permissions();
+
+	synchronize_to_clock_tick();
+	ur->read_hardware_clock(&tm);
+
+	gettimeofday(&tv, NULL);
+	time1_sys = tv.tv_sec + tv.tv_usec / 1000000.0;
+
+	mktime_tz(tm, universal, &hclock_valid, &time1_hw);
+
+  bool first_pass = TRUE;
+
+	while (TRUE)
+	{
+		synchronize_to_clock_tick();
+		ur->read_hardware_clock(&tm);
+
+		gettimeofday(&tv, NULL);
+		time2_sys = tv.tv_sec + tv.tv_usec / 1000000.0;
+
+		mktime_tz(tm, universal, &hclock_valid, &time2_hw);
+
+		double res = ((time1_hw - time1_sys) - (time2_hw - time2_sys))
+				/ (time2_hw - time1_hw);
+
+		if(!first_pass)
+			printf ("sysclock/RTC frequency offset: %.0f ppm (%.0f ticks)\n",
+				res * 1e6, res *1e4);
+		else {
+			first_pass = FALSE;
+			printf ("sysclock/RTC frequency offset:    ppm (   ticks)\n");
+		}
+		sleep(10);
+	}
+}
+
 static void out_version(void)
 {
 	printf(_("%s from %s\n"), program_invocation_short_name, PACKAGE_STRING);
@@ -1370,7 +1425,8 @@ static void usage(const char *fmt, ...)
 		" -w, --systohc        set the hardware clock from the current system time\n"
 		"     --systz          set the system time based on the current timezone\n"
 		"     --adjust         adjust the RTC to account for systematic drift since\n"
-		"                        the clock was last set or adjusted\n"), usageto);
+		"                        the clock was last set or adjusted\n"
+		" -c  --compare        periodically compare the system clock with the CMOS clock\n"), usageto);
 #ifdef __linux__
 	fputs(_("     --getepoch       print out the kernel's hardware clock epoch value\n"
 		"     --setepoch       set the kernel's hardware clock epoch value to the \n"
@@ -1438,7 +1494,7 @@ int main(int argc, char **argv)
 	/* Variables set by various options; show may also be set later */
 	/* The options debug, badyear and epoch_option are global */
 	bool show, set, systohc, hctosys, systz, adjust, getepoch, setepoch,
-	    predict;
+	    predict, compare;
 	bool utc, testing, local_opt, noadjfile, directisa;
 	char *date_opt;
 #ifdef __alpha__
@@ -1463,6 +1519,7 @@ int main(int argc, char **argv)
 
 	static const struct option longopts[] = {
 		{"adjust",	0, 0, 'a'},
+		{"compare",	0, 0, 'c'},
 		{"help",	0, 0, 'h'},
 		{"show",	0, 0, 'r'},
 		{"hctosys",	0, 0, 's'},
@@ -1540,7 +1597,7 @@ int main(int argc, char **argv)
 
 	/* Set option defaults */
 	show = set = systohc = hctosys = systz = adjust = noadjfile = predict =
-	    FALSE;
+	    compare = FALSE;
 	getepoch = setepoch = utc = local_opt = directisa = testing = debug = FALSE;
 #ifdef __alpha__
 	ARCconsole = Jensen = SRM = funky_toy = badyear = FALSE;
@@ -1548,7 +1605,7 @@ int main(int argc, char **argv)
 	date_opt = NULL;
 
 	while ((c = getopt_long(argc, argv,
-				"?hvVDarsuwAJSFf:", longopts, NULL)) != -1) {
+				"?hvVDacrsuwAJSFf:", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1559,6 +1616,9 @@ int main(int argc, char **argv)
 		case 'a':
 			adjust = TRUE;
 			break;
+		case 'c':
+			compare = TRUE;
+			break;
 		case 'r':
 			show = TRUE;
 			break;
@@ -1733,6 +1793,13 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (compare) {
+		if (compare_clock(utc, local_opt))
+			hwclock_exit(EX_NOPERM);
+		else
+			hwclock_exit(EX_OK);
+	}
+
 	rc = manipulate_clock(show, adjust, noadjfile, set, set_time,
 			      hctosys, systohc, systz, startup_time, utc,
 			      local_opt, testing, predict);
-- 
1.7.11.4


--------------030901060009000604000602--
