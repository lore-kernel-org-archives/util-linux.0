Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbdFZSaB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 14:30:01 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ7bs-1dBCmc2RWm-00L1v0 for
 <util-linux@vger.kernel.org>; Mon, 26 Jun 2017 20:29:54 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/6] blockdev: improve --help and man page
Date: Mon, 26 Jun 2017 20:29:50 +0200
Message-Id: <20170626182952.15988-5-sweet_f_a@gmx.de>
In-Reply-To: <20170626182952.15988-1-sweet_f_a@gmx.de>
References: <20170626182952.15988-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/blockdev.8 |  9 +++++++--
 disk-utils/blockdev.c | 34 +++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/disk-utils/blockdev.8 b/disk-utils/blockdev.8
index c9eeb9b41..0f3291391 100644
--- a/disk-utils/blockdev.8
+++ b/disk-utils/blockdev.8
@@ -17,13 +17,14 @@ blockdev \- call block device ioctls from the command line
 .B blockdev
 .B \-\-report
 .RI [ device \&...\&]
+.br
+.B blockdev
+.RB \-h | \-V
 .SH DESCRIPTION
 The utility
 .B blockdev
 allows one to call block device ioctls from the command line.
 .SH OPTIONS
-.IP "\fB\-V\fP"
-Print version and exit.
 .IP "\fB\-q\fP"
 Be quiet.
 .IP "\fB\-v\fP"
@@ -32,6 +33,10 @@ Be verbose.
 Print a report for the specified device. It is possible to give multiple
 devices. If none is given, all devices which appear in /proc/partitions are
 shown. Note that the partition StartSec is in 512-byte sectors.
+.IP "\fB\-h\fR, \fB\-\-help\fR"
+Display help text and exit.
+.IP "\fB\-V\fR, \fB\-\-version\fR"
+Print version and exit.
 .SH COMMANDS
 It is possible to give multiple devices and multiple commands.
 .IP "\fB\-\-flushbufs\fP"
diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index 4760e021b..ef502e0a3 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -180,27 +180,39 @@ static const struct bdc bdcms[] =
 
 static void __attribute__((__noreturn__)) usage(void)
 {
-	FILE * out = stdout;
 	size_t i;
 
-	fprintf(out, _("\nUsage:\n"
-		       " %1$s -V\n"
-		       " %1$s --report [devices]\n"
-		       " %1$s [-v|-q] commands devices\n\n"
-		       "Available commands:\n"), program_invocation_short_name);
-
-	fprintf(out, _(" %-25s get size in 512-byte sectors\n"), "--getsz");
+	fputs(USAGE_HEADER, stdout);
+	printf(_(
+	         " %1$s [-v|-q] commands devices\n"
+	         " %1$s --report [devices]\n"
+	         " %1$s -h|-V\n"
+		), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	puts(  _("Call block device ioctls from the command line."));
+
+	fputs(USAGE_OPTIONS, stdout);
+	puts(  _(" -q             quiet mode"));
+	puts(  _(" -v             verbose mode"));
+	puts(  _("     --report   print report for specified (or all) devices"));
+	fputs(USAGE_SEPARATOR, stdout);
+	PRINT_USAGE_HELP(16);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	puts(  _("Available commands:"));
+	printf(_(" %-25s get size in 512-byte sectors\n"), "--getsz");
 	for (i = 0; i < ARRAY_SIZE(bdcms); i++) {
 		if (bdcms[i].argname)
-			fprintf(out, " %s %-*s %s\n", bdcms[i].name,
+			printf(" %s %-*s %s\n", bdcms[i].name,
 				(int)(24 - strlen(bdcms[i].name)),
 				bdcms[i].argname, _(bdcms[i].help));
 		else
-			fprintf(out, " %-25s %s\n", bdcms[i].name,
+			printf(" %-25s %s\n", bdcms[i].name,
 				_(bdcms[i].help));
 	}
 
-	fprintf(out, USAGE_MAN_TAIL("blockdev(1)"));
+	printf(USAGE_MAN_TAIL("blockdev(1)"));
 	exit(EXIT_SUCCESS);
 }
 
-- 
2.12.3

