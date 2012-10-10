Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37006 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab2JJHoJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Oct 2012 03:44:09 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9A7i8X6030381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 10 Oct 2012 03:44:08 -0400
Received: from [10.34.4.104] (unused-4-104.brq.redhat.com [10.34.4.104])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q9A7i6cv001571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Wed, 10 Oct 2012 03:44:08 -0400
Message-ID: <50752745.4020607@redhat.com>
Date: Wed, 10 Oct 2012 09:44:05 +0200
From: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] dmesg colorized output
Content-Type: multipart/mixed;
 boundary="------------000003050609080907090009"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000003050609080907090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this patch should implement the dmesg entry in your TODO list.
I've also created a tiny colors module, which should be enough for
simple output coloring for other programs in the future.
Cheers,
  Ondrej.


--------------000003050609080907090009
Content-Type: text/plain; charset=UTF-8;
 name="DIFF"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="DIFF"

>From 1a89c8497525030c8710c3936aa8d558976f0502 Mon Sep 17 00:00:00 2001
From: Ondrej Oprala <ooprala@redhat.com>
Date: Tue, 9 Oct 2012 12:32:55 +0200
Subject: [PATCH] dmesg: Add a --color option to colorize error and panic
 messages

---
 include/colors.h  | 19 +++++++++++++++++++
 lib/Makemodule.am |  1 +
 lib/colors.c      | 20 ++++++++++++++++++++
 sys-utils/dmesg.c | 28 ++++++++++++++++++++++++----
 4 files changed, 64 insertions(+), 4 deletions(-)
 create mode 100644 include/colors.h
 create mode 100644 lib/colors.c

diff --git a/include/colors.h b/include/colors.h
new file mode 100644
index 0000000..90b62a7
--- /dev/null
+++ b/include/colors.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2012 Ondrej Oprala <ooprala@redhat.com>
+ *
+ * This file may be distributed under the terms of the
+ * GNU Lesser General Public License.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#define CLR_RST "\033[0m"
+
+/*
+ * Set output colors according to CLR_SCHEME, which should
+ * be in ANSI color code format
+ */
+extern void set_clr(const char *clr_scheme, FILE *out);
+
+/* Reset to default */
+extern void rst_clr(FILE *out);
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 33a3eb8..3c89fb8 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -5,6 +5,7 @@ libcommon_la_SOURCES = \
 	lib/at.c \
 	lib/blkdev.c \
 	lib/canonicalize.c \
+	lib/colors.c \
 	lib/cpuset.c \
 	lib/crc32.c \
 	lib/env.c \
diff --git a/lib/colors.c b/lib/colors.c
new file mode 100644
index 0000000..0e03f98
--- /dev/null
+++ b/lib/colors.c
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2012 Ondrej Oprala <ooprala@redhat.com>
+ *
+ * This file may be distributed under the terms of the
+ * GNU Lesser General Public License.
+ */
+
+#include "colors.h"
+
+void set_clr(const char *clr_scheme, FILE *out)
+{
+	if (isatty(fileno(out)))
+		fprintf(out, clr_scheme);
+}
+
+void rst_clr(FILE *out)
+{
+	if (isatty(fileno(out)))
+		fprintf(out, CLR_RST);
+}
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 4c85f9f..fc384d7 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -23,6 +23,7 @@
 #include <fcntl.h>
 
 #include "c.h"
+#include "colors.h"
 #include "nls.h"
 #include "strutils.h"
 #include "xalloc.h"
@@ -33,6 +34,11 @@
 #include "optutils.h"
 #include "mangle.h"
 
+#define K_PANIC 1
+#define K_ERR 3
+#define CLR_PANIC "\033[31m" //Red
+#define CLR_ERR "\033[1;31m" //Bright Red
+
 /* Close the log.  Currently a NOP. */
 #define SYSLOG_ACTION_CLOSE          0
 /* Open the log. Currently a NOP. */
@@ -147,7 +153,8 @@ struct dmesg_control {
 			notime:1,	/* don't print timestamp */
 			delta:1,	/* show time deltas */
 			reltime:1,	/* show human readable relative times */
-			ctime:1;	/* show human readable time */
+			ctime:1,	/* show human readable time */
+			color:1;	/* colorize error and panic messages */
 };
 
 struct dmesg_record {
@@ -193,6 +200,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		" -f, --facility <list>       restrict output to defined facilities\n"
 		" -h, --help                  display this help and exit\n"
 		" -k, --kernel                display kernel messages\n"
+		" -L, --color                 colorize error and panic messages\n"
 		" -l, --level <list>          restrict output to defined levels\n"
 		" -n, --console-level <level> set level of messages printed to console\n"
 		" -r, --raw                   print the raw message buffer\n"
@@ -839,8 +847,16 @@ static void print_record(struct dmesg_control *ctl,
 		printf("[%5d.%06d] ", (int) rec->tv.tv_sec, (int) rec->tv.tv_usec);
 
 mesg:
+  //Change the output color for panic and error messages
+  if (ctl->color)
+    set_clr(rec->level == K_PANIC ? CLR_PANIC :
+        rec->level == K_ERR ? CLR_ERR : CLR_RST, stdout);
+
 	safe_fwrite(rec->mesg, rec->mesg_size, stdout);
 
+  if (ctl->color)
+    rst_clr(stdout);
+
 	if (*(rec->mesg + rec->mesg_size - 1) != '\n')
 		putchar('\n');
 }
@@ -1046,6 +1062,7 @@ int main(int argc, char *argv[])
 	static const struct option longopts[] = {
 		{ "buffer-size",   required_argument, NULL, 's' },
 		{ "clear",         no_argument,	      NULL, 'C' },
+		{ "color",         no_argument,	      NULL, 'L' },
 		{ "console-level", required_argument, NULL, 'n' },
 		{ "console-off",   no_argument,       NULL, 'D' },
 		{ "console-on",    no_argument,       NULL, 'E' },
@@ -1080,7 +1097,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "CcDdEeF:f:hkl:n:rSs:TtuVwx",
+	while ((c = getopt_long(argc, argv, "CcDdEeF:f:hkLl:n:rSs:TtuVwx",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -1123,6 +1140,9 @@ int main(int argc, char *argv[])
 			ctl.fltr_fac = 1;
 			setbit(ctl.facilities, FAC_BASE(LOG_KERN));
 			break;
+		case 'L':
+			ctl.color = 1;
+			break;
 		case 'l':
 			ctl.fltr_lev= 1;
 			if (string_to_bitarray(optarg,
@@ -1180,9 +1200,9 @@ int main(int argc, char *argv[])
 		usage(stderr);
 
 	if (ctl.raw && (ctl.fltr_lev || ctl.fltr_fac || ctl.delta ||
-			ctl.notime || ctl.ctime || ctl.decode))
+			ctl.notime || ctl.ctime || ctl.decode || ctl.color))
 		errx(EXIT_FAILURE, _("--raw can't be used together with level, "
-		     "facility, decode, delta, ctime or notime options"));
+		     "facility, decode, delta, ctime, notime or color options"));
 
 	if (ctl.notime && (ctl.ctime || ctl.reltime))
 		errx(EXIT_FAILURE, _("--notime can't be used together with --ctime or --reltime"));
-- 
1.7.11.4


--------------000003050609080907090009--
