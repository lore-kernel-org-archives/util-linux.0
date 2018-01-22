Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f182.google.com ([209.85.128.182]:40469 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeAVUqN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 Jan 2018 15:46:13 -0500
Received: by mail-wr0-f182.google.com with SMTP id 100so10146006wrb.7
        for <util-linux@vger.kernel.org>; Mon, 22 Jan 2018 12:46:13 -0800 (PST)
From: Libor Bukata <lbukata@gmail.com>
Subject: Patch to add support for lz4hc and deflate optimization algorithms in
 zramctl.
To: util-linux@vger.kernel.org
Cc: Nefelim4ag@gmail.com, kzak@redhat.com
Message-ID: <90fb3b4a-38b8-17fc-f1b6-03e8c23eb808@gmail.com>
Date: Mon, 22 Jan 2018 21:45:54 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------94CCBBA2680FFE7AC0805643"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------94CCBBA2680FFE7AC0805643
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit

Dear developers of Linux utils,

I extended the zramctl utility to handle also lz4hc and deflate formats.
The patch is included in the attachment. Thank you in advance for your
comments.

Kind regards,
Libor Bukata.

--------------94CCBBA2680FFE7AC0805643
Content-Type: text/x-patch;
 name="new_comp_alg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="new_comp_alg.patch"

diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
index 9ca2983b9..ef44435ed 100644
--- a/sys-utils/zramctl.8
+++ b/sys-utils/zramctl.8
@@ -44,7 +44,7 @@ query the status of used zram devices.
 If no option is given, all non-zero size zram devices are shown.
 .SH OPTIONS
 .TP
-.BR \-a , " \-\-algorithm lzo" | lz4
+.BR \-a , " \-\-algorithm lzo" | lz4 | lz4hc | deflate
 Set the compression algorithm to be used for compressing data in the zram device.
 .TP
 .BR \-f , " \-\-find"
diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index fb64150d6..9117ddce3 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -424,13 +424,16 @@ static void fill_table_row(struct libscols_table *tb, struct zram *z)
 			char *alg = sysfs_strdup(sysfs, "comp_algorithm");
 			if (!alg)
 				break;
-			if (strstr(alg, "[lzo]") == NULL) {
-				if (strstr(alg, "[lz4]") == NULL)
-					;
-				else
-					str = xstrdup("lz4");
-			} else
+
+			if (strstr(alg, "[lzo]") != NULL)
 				str = xstrdup("lzo");
+			else if (strstr(alg, "[lz4]") != NULL)
+				str = xstrdup("lz4");
+			else if (strstr(alg, "[lz4hc]") != NULL)
+				str = xstrdup("lz4hc");
+			else if (strstr(alg, "[deflate]") != NULL)
+				str = xstrdup("deflate");
+
 			free(alg);
 			break;
 		}
@@ -539,7 +542,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Set up and control zram devices.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -a, --algorithm lzo|lz4   compression algorithm to use\n"), out);
+	fputs(_(" -a, --algorithm lzo|lz4|lz4hc|deflate   compression algorithm to use\n"), out);
 	fputs(_(" -b, --bytes               print sizes in bytes rather than in human readable format\n"), out);
 	fputs(_(" -f, --find                find a free device\n"), out);
 	fputs(_(" -n, --noheadings          don't print headings\n"), out);
@@ -611,7 +614,8 @@ int main(int argc, char **argv)
 
 		switch (c) {
 		case 'a':
-			if (strcmp(optarg,"lzo") && strcmp(optarg,"lz4"))
+			if (strcmp(optarg,"lzo") && strcmp(optarg,"lz4")
+					&& strcmp(optarg,"lz4hc") && strcmp(optarg, "deflate"))
 				errx(EXIT_FAILURE, _("unsupported algorithm: %s"),
 					     optarg);
 			algorithm = optarg;

--------------94CCBBA2680FFE7AC0805643--
