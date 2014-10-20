Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:55792 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598AbaJTT5t (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Oct 2014 15:57:49 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] sfdisk: change option --label-nested to --nested-label
Date: Mon, 20 Oct 2014 21:57:43 +0200
Message-Id: <1413835063-2819-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also improve the wording of the option description in the man page a bit.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/sfdisk.8 |   17 +++++++++--------
 disk-utils/sfdisk.c |    6 +++---
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 029083f..f4f2a1d 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -142,14 +142,15 @@ Deprecated option. The sector unit is supported only.
 Deprecated and ignored option. Linux (and another moder OS) compatible
 partitioning is the default.
 .TP
-.BR \-X , " \-\-label \fItype\fR
-Specify disk label type (e.g. dos, gpt, ...). If no label specified then sfdisk
-defaults to an existing label. If there is no label on the device than defaults
-to "dos".
-.TP
-.BR \-Y , " \-\-label-nested \fItype\fR
-Force sfdisk to edit nested disk label. The primary disk label has to already exist.
-This option allows to edit for example hybrid/protective MBR on devices with GPT.
+.BR \-X , " \-\-label " \fItype
+Specify the disk label type (dos, bsd, gpt, ...).  If this option is not given,
+then the type defaults to that of the existing label.  If there is no label on
+the device yet, then the type defaults to "dos".
+.TP
+.BR \-Y , " \-\-nested-label " \fItype
+Force \fBsfdisk\fR to edit a nested disk label.  The primary disk label has to
+exist already.
+This option allows editing a hybrid or protective MBR on devices with a GPT.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 49369bd..43bcb1c 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -79,7 +79,7 @@ struct sfdisk {
 	int		act;		/* ACT_* */
 	int		partno;		/* -N <partno>, default -1 */
 	const char	*label;		/* --label <label> */
-	const char	*label_nested;	/* --label-nested <label> */
+	const char	*label_nested;	/* --nested-label <label> */
 	const char	*backup_file;	/* -O <path> */
 
 	struct fdisk_context	*cxt;	/* libfdisk context */
@@ -1337,7 +1337,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(_(" -O, --backup-file <path>  override default backout file name\n"), out);
 	fputs(_(" -N, --partno <num>        specify partition number\n"), out);
 	fputs(_(" -X, --label <name>        specify label type (dos, gpt, ...)\n"), out);
-	fputs(_(" -Y, --label-nested <name> specify nested label type (dos, bsd)\n"), out);
+	fputs(_(" -Y, --nested-label <name> specify nested label type (dos, bsd)\n"), out);
 	fputs(_(" -q, --quiet               suppress extra info messages\n"), out);
 	fputs(_(" -n, --no-act              do everything except write to device\n"), out);
 	fputs(_("     --no-reread           do not check whether the device is in use\n"), out);
@@ -1385,9 +1385,9 @@ int main(int argc, char *argv[])
 		{ "help",    no_argument,       NULL, 'h' },
 		{ "force",   no_argument,       NULL, 'f' },
 		{ "label",   required_argument, NULL, 'X' },
-		{ "label-nested", required_argument, NULL, 'Y' },
 		{ "list",    no_argument,       NULL, 'l' },
 		{ "list-types", no_argument,	NULL, 'T' },
+		{ "nested-label", required_argument, NULL, 'Y' },
 		{ "no-act",  no_argument,       NULL, 'n' },
 		{ "no-reread", no_argument,     NULL, OPT_NOREREAD },
 		{ "output",  required_argument, NULL, 'o' },
-- 
1.7.0.4

