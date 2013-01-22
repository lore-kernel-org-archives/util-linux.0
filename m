Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:46865 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX1d (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:33 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so191085wib.15
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:32 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/14] lsblk: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:05 +0000
Message-Id: <1358897233-6676-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/lsblk.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 8ee6974..a9674c1 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1325,31 +1325,30 @@ static void __attribute__((__noreturn__)) help(FILE *out)
 {
 	size_t i;
 
-	fprintf(out, _(
-		"\nUsage:\n"
-		" %s [options] [<device> ...]\n"), program_invocation_short_name);
-
-	fprintf(out, _(
-		"\nOptions:\n"
-		" -a, --all            print all devices\n"
-		" -b, --bytes          print SIZE in bytes rather than in human readable format\n"
-		" -d, --nodeps         don't print slaves or holders\n"
-		" -D, --discard        print discard capabilities\n"
-		" -e, --exclude <list> exclude devices by major number (default: RAM disks)\n"
-		" -I, --include <list> show only devices with specified major numbers\n"
-		" -f, --fs             output info about filesystems\n"
-		" -h, --help           usage information (this)\n"
-		" -i, --ascii          use ascii characters only\n"
-		" -m, --perms          output info about permissions\n"
-		" -l, --list           use list format output\n"
-		" -n, --noheadings     don't print headings\n"
-		" -o, --output <list>  output columns\n"
-		" -P, --pairs          use key=\"value\" output format\n"
-		" -r, --raw            use raw output format\n"
-		" -s, --inverse        inverse dependencies\n"
-		" -t, --topology       output info about topology\n"
-		" -S, --scsi           output info about SCSI devices\n"
-		" -V, --version        output version information and exit\n"));
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] [<device> ...]\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -a, --all            print all devices\n"), out);
+	fputs(_(" -b, --bytes          print SIZE in bytes rather than in human readable format\n"), out);
+	fputs(_(" -d, --nodeps         don't print slaves or holders\n"), out);
+	fputs(_(" -D, --discard        print discard capabilities\n"), out);
+	fputs(_(" -e, --exclude <list> exclude devices by major number (default: RAM disks)\n"), out);
+	fputs(_(" -I, --include <list> show only devices with specified major numbers\n"), out);
+	fputs(_(" -f, --fs             output info about filesystems\n"), out);
+	fputs(_(" -h, --help           usage information (this)\n"), out);
+	fputs(_(" -i, --ascii          use ascii characters only\n"), out);
+	fputs(_(" -m, --perms          output info about permissions\n"), out);
+	fputs(_(" -l, --list           use list format output\n"), out);
+	fputs(_(" -n, --noheadings     don't print headings\n"), out);
+	fputs(_(" -o, --output <list>  output columns\n"), out);
+	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), out);
+	fputs(_(" -r, --raw            use raw output format\n"), out);
+	fputs(_(" -s, --inverse        inverse dependencies\n"), out);
+	fputs(_(" -t, --topology       output info about topology\n"), out);
+	fputs(_(" -S, --scsi           output info about SCSI devices\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 
 	fprintf(out, _("\nAvailable columns (for --output):\n"));
 
-- 
1.8.1.1

