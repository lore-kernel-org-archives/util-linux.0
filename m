Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:62510 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbaHCXIS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 19:08:18 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so4037478wib.14
        for <util-linux@vger.kernel.org>; Sun, 03 Aug 2014 16:08:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 8/8] zramctl: allow use of --algorithm and --streams alone
Date: Mon,  4 Aug 2014 00:08:10 +0100
Message-Id: <1407107290-5806-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier the --algorithm and --streams had to be combined with --size.  To
user requirement to combine with --size was indirectly told using
following message.

$ zramctl --stream 3 zram3
zramctl: options --algorithm, --find and --streams are mutually exclusive

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/zramctl.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index afbc0e8..43b7dcb 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -388,7 +388,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_("     --raw                 use raw status output format\n"), out);
 	fputs(_(" -r, --reset               reset all specified devices\n"), out);
 	fputs(_(" -s, --size <size>         device size\n"), out);
-	fputs(_(" -t, --streams <number>    number of compressoin streams\n\n"), out);
+	fputs(_(" -t, --streams <number>    number of compressoin streams\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -408,6 +408,7 @@ enum {
 	A_STATUS,
 	A_CREATE,
 	A_FINDONLY,
+	A_SETTINGS,
 	A_RESET
 };
 
@@ -502,8 +503,12 @@ int main(int argc, char **argv)
 	if (find && optind < argc)
 		errx(EXIT_FAILURE, _("option --find is mutually exclusive "
 				     "with <device>"));
-	if (act == A_NONE)
-		act = find ? A_FINDONLY : A_STATUS;
+	if (act == A_NONE) {
+		if (algorithm || nstreams)
+			act = A_SETTINGS;
+		else
+			act = find ? A_FINDONLY : A_STATUS;
+	}
 
 	if (act != A_RESET && optind + 1 < argc)
 		errx(EXIT_FAILURE, _("only one <device> at a time is allowed"));
@@ -552,6 +557,7 @@ int main(int argc, char **argv)
 		free_zram(zram);
 		break;
 	case A_CREATE:
+	case A_SETTINGS:
 		if (find) {
 			zram = find_free_zram();
 			if (!zram)
@@ -561,8 +567,9 @@ int main(int argc, char **argv)
 		else
 			zram = new_zram(argv[optind]);
 
-		if (zram_set_u64parm(zram, "reset", 1))
-			err(EXIT_FAILURE, _("%s: failed to reset"), zram->devname);
+		if (act == A_CREATE)
+			if (zram_set_u64parm(zram, "reset", 1))
+				err(EXIT_FAILURE, _("%s: failed to reset"), zram->devname);
 
 		if (nstreams &&
 		    zram_set_u64parm(zram, "max_comp_streams", nstreams))
@@ -572,9 +579,10 @@ int main(int argc, char **argv)
 		    zram_set_strparm(zram, "comp_algorithm", algorithm))
 			err(EXIT_FAILURE, _("%s: failed to set algorithm"), zram->devname);
 
-		if (zram_set_u64parm(zram, "disksize", size))
-			err(EXIT_FAILURE, _("%s: failed to set disksize (%ju bytes)"),
-				zram->devname, size);
+		if (act == A_CREATE)
+			if (zram_set_u64parm(zram, "disksize", size))
+				err(EXIT_FAILURE, _("%s: failed to set disksize (%ju bytes)"),
+				    zram->devname, size);
 		if (find)
 			printf("%s\n", zram->devname);
 		free_zram(zram);
-- 
2.0.3

