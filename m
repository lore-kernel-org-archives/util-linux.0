Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:50711 "EHLO
        cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751446AbdBIQ1J (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Feb 2017 11:27:09 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH v2] blkreport: slice up option descriptions, fix typo, fix docstring
Date: Thu,  9 Feb 2017 17:24:00 +0100
Message-Id: <20170209162400.3725-1-bensberg@justemail.net>
In-Reply-To: <20170209152314.3473-1-bensberg@justemail.net>
References: <20170209152314.3473-1-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Each option plus its description should be a separate translatable
string.  And, if all is well, blkreport should not discard anything
-- that is: fix the cut-and-paste error from blkdiscard.

Additionally, tweak some wordings.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/blkreport.8 | 19 ++++++++-----------
 sys-utils/blkreport.c | 13 ++++++-------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/sys-utils/blkreport.8 b/sys-utils/blkreport.8
index 8c4943e81..81417d4ad 100644
--- a/sys-utils/blkreport.8
+++ b/sys-utils/blkreport.8
@@ -1,4 +1,4 @@
-.TH BLKREPORT 5 "March 2016" "util-linux" "System Administration"
+.TH BLKREPORT 8 "February 2017" "util-linux" "System Administration"
 .SH NAME
 blkreport \- report zones on a device
 .SH SYNOPSIS
@@ -17,23 +17,23 @@ zoned devices that support the ZAC or ZBC command set.
 By default,
 .B blkreport
 will report on up to 4k zones from the start of the block device.
-Options may be used to modify this behavior based on the starting zone or
-size of the report, as explained below.
+Options may be used to modify this behavior, changing the starting zone or
+the size of the report, as explained below.
 .PP
 The
 .I device
 argument is the pathname of the block device.
-.PP
 .SH OPTIONS
 The
 .I offset
 and
 .I length
-arguments may be followed by the multiplicative suffixes KiB (=1024),
+option arguments may be followed by the multiplicative suffixes KiB (=1024),
 MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
 optional, e.g., "K" has the same meaning as "KiB") or the suffixes
 KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
-Additionally the common 0x prefix can be used to specify zone and length in hex.
+Additionally, the 0x prefix can be used to specify \fIoffset\fR and
+\fIlength\fR in hex.
 .TP
 .BR \-z , " \-\-zone "\fIoffset\fP
 The starting zone of the report specified as a sector offset.
@@ -41,14 +41,11 @@ The provided offset in sector units (512 bytes) should match the start of a zone
 The default value is zero.
 .TP
 .BR \-c , " \-\-count "\fIlength\fP
-The maximum number of zones to be returned by the report from the block device.
-Default is 4006, max is 65536
+The maximum number of zones to be returned by the report.
+The default is 4096, the maximum 65536.
 .TP
 .BR \-v , " \-\-verbose"
 Display the number of zones returned in the report.
-.I offset
-and
-.IR length .
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
diff --git a/sys-utils/blkreport.c b/sys-utils/blkreport.c
index fe88a7308..13f2adad2 100644
--- a/sys-utils/blkreport.c
+++ b/sys-utils/blkreport.c
@@ -123,20 +123,19 @@ static int do_report(int fd, uint64_t lba, uint32_t len, int verbose)
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
-	fprintf(out,
-	      _(" %s [options] <device>\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] <device>\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_("Discard the content of sectors on a device.\n"), out);
+	fputs(_("Report zone information about the given device.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -z, --zone <offset>    zone LBA in 512 byte sectors\n"
-		" -c, --count <length>   maximum number of zones in report\n"
-		" -v, --verbose          print aligned length and offset"),
-		out);
+	fputs(_(" -z, --zone <offset>    LBA of first zone (in 512-byte sectors)\n"), out);
+	fputs(_(" -c, --count <number>   maximum number of zones in the report\n"), out);
+	fputs(_(" -v, --verbose          display the number of reported zones"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
+
 	fprintf(out, USAGE_MAN_TAIL("blkreport(8)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
2.11.0

