Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:59871 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbaHAMTT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 1 Aug 2014 08:19:19 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] zramctl: fix the wording of some message strings
Date: Fri,  1 Aug 2014 14:19:07 +0200
Message-Id: <1406895548-2925-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/zramctl.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 2215898..a26cd8e 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -1,5 +1,5 @@
 /*
- * zramctl - purpose of it
+ * zramctl - control compressed block devices in RAM
  *
  * Copyright (c) 2014 Timofey Titovets <Nefelim4ag@gmail.com>
  * Copyright (C) 2014 Karel Zak <kzak@redhat.com>
@@ -65,15 +65,14 @@ enum {
 
 static const struct colinfo infos[] = {
 	[COL_NAME]      = { "NAME",      0.25, 0, N_("zram device name") },
-	[COL_DISKSIZE]  = { "DISKSIZE",     5, SCOLS_FL_RIGHT, N_("limit on the uncompressed worth of data") },
+	[COL_DISKSIZE]  = { "DISKSIZE",     5, SCOLS_FL_RIGHT, N_("limit on the uncompressed amount of data") },
 	[COL_ORIG_SIZE] = { "DATA",         5, SCOLS_FL_RIGHT, N_("uncompressed size of stored data") },
 	[COL_COMP_SIZE] = { "COMPR",        5, SCOLS_FL_RIGHT, N_("compressed size of stored data") },
-	[COL_ALGORITHM] = { "ALGORITHM",    3, 0, N_("selected compression algorithms") },
+	[COL_ALGORITHM] = { "ALGORITHM",    3, 0, N_("the selected compression algorithm") },
 	[COL_STREAMS]   = { "STREAMS",      3, SCOLS_FL_RIGHT, N_("number of concurrent compress operations") },
 	[COL_ZEROPAGES] = { "ZERO-PAGES",   3, SCOLS_FL_RIGHT, N_("empty pages with no allocated memory") },
 	[COL_MEMTOTAL]  = { "TOTAL",        5, SCOLS_FL_RIGHT, N_("all memory including allocator fragmentation and metadata overhead") },
 	[COL_MOUNTPOINT]= { "MOUNTPOINT",0.10, SCOLS_FL_TRUNC, N_("where the device is mounted") },
-
 };
 
 static int columns[ARRAY_SIZE(infos) * 2] = {-1};
@@ -366,19 +365,19 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(	" %1$s [options] <device>\n"
-			" %1$s -r <device> [...]\n" 
+			" %1$s -r <device> [...]\n"
 			" %1$s [options] -f | <device> -s <size>\n"),
 			program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -a, --algorithm <lzo|lz4> compression algorithm\n"), out);
+	fputs(_(" -a, --algorithm lzo|lz4   compression algorithm to use\n"), out);
 	fputs(_(" -b, --bytes               print sizes in bytes rather than in human readable format\n"), out);
-	fputs(_(" -f, --find                find free device\n"), out);
+	fputs(_(" -f, --find                find a free device\n"), out);
 	fputs(_(" -n, --noheadings          don't print headings\n"), out);
 	fputs(_(" -o, --output <list>       columns to use for status output\n"), out);
+	fputs(_("     --raw                 use raw status output format\n"), out);
 	fputs(_(" -r, --reset               reset all specified devices\n"), out);
 	fputs(_(" -s, --size <size>         device size\n"), out);
-	fputs(_("     --raw                 use raw status output format\n"), out);
 	fputs(_(" -t, --streams <number>    number of compressoin streams\n\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -413,9 +412,9 @@ int main(int argc, char **argv)
 
 	static const struct option longopts[] = {
 		{ "algorithm", required_argument, NULL, 'a' },
+		{ "bytes",     no_argument, NULL, 'b' },
 		{ "find",      no_argument, NULL, 'f' },
 		{ "help",      no_argument, NULL, 'h' },
-		{ "bytes",     no_argument, NULL, 'b' },
 		{ "output",    required_argument, NULL, 'o' },
 		{ "noheadings",no_argument, NULL, 'n' },
 		{ "reset",     no_argument, NULL, 'r' },
@@ -490,7 +489,7 @@ int main(int argc, char **argv)
 
 	if (find && optind < argc)
 		errx(EXIT_FAILURE, _("option --find is mutually exclusive "
-				     "with <device>."));
+				     "with <device>"));
 	if (act == A_NONE)
 		act = find ? A_FINDONLY : A_STATUS;
 
@@ -501,7 +500,7 @@ int main(int argc, char **argv)
 	case A_STATUS:
 		if (algorithm || find || nstreams)
 			errx(EXIT_FAILURE, _("options --algorithm, --find and "
-					"--streams are mutually exclusive."));
+					"--streams are mutually exclusive"));
 		if (!ncolumns) {		/* default columns */
 			columns[ncolumns++] = COL_NAME;
 			columns[ncolumns++] = COL_ALGORITHM;
@@ -533,7 +532,7 @@ int main(int argc, char **argv)
 	case A_FINDONLY:
 		zram = find_free_zram();
 		if (!zram)
-			errx(EXIT_FAILURE, _("no found free zram device"));
+			errx(EXIT_FAILURE, _("no free zram device found"));
 		printf("%s\n", zram->devname);
 		free_zram(zram);
 		break;
@@ -541,7 +540,7 @@ int main(int argc, char **argv)
 		if (find) {
 			zram = find_free_zram();
 			if (!zram)
-				errx(EXIT_FAILURE, _("no found free zram device"));
+				errx(EXIT_FAILURE, _("no free zram device found"));
 		} else if (optind == argc)
 			errx(EXIT_FAILURE, _("no device specified"));
 		else
-- 
1.7.0.4

