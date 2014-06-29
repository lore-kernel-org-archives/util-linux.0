Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:50646 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558AbaF2PuW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 29 Jun 2014 11:50:22 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/7] textual: minimally improve wording of usage text of findmnt
Date: Sun, 29 Jun 2014 17:49:42 +0200
Message-Id: <1404056983-10119-6-git-send-email-bensberg@justemail.net>
In-Reply-To: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
References: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also sort the options better and tweak whitespace.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/findmnt.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 06fdd8f..445a9b3 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1138,7 +1138,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -s, --fstab            search in static table of filesystems\n"), out);
 	fputs(_(" -m, --mtab             search in table of mounted filesystems\n"), out);
 	fputs(_(" -k, --kernel           search in kernel table of mounted\n"
-              "                          filesystems (default)\n"), out);
+		"                          filesystems (default)\n"), out);
 	fputc('\n', out);
 	fputs(_(" -p, --poll[=<list>]    monitor changes in table of mounted filesystems\n"), out);
 	fputs(_(" -w, --timeout <num>    upper limit in milliseconds that --poll will block\n"), out);
@@ -1147,8 +1147,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -A, --all              disable all built-in filters, print all filesystems\n"), out);
 	fputs(_(" -a, --ascii            use ASCII chars for tree formatting\n"), out);
 	fputs(_(" -b, --bytes            print sizes in bytes rather than in human readable format\n"), out);
+	fputs(_(" -C, --nocanonicalize   don't canonicalize when comparing paths\n"), out);
 	fputs(_(" -c, --canonicalize     canonicalize printed paths\n"), out);
-	fputs(_(" -C, --nocanonicalize   don't canonicalize when compare paths\n"), out);
 	fputs(_(" -D, --df               imitate the output of df(1)\n"), out);
 	fputs(_(" -d, --direction <word> direction of search, 'forward' or 'backward'\n"), out);
 	fputs(_(" -e, --evaluate         convert tags (LABEL,UUID,PARTUUID,PARTLABEL) \n"
@@ -1159,18 +1159,18 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -l, --list             use list format output\n"), out);
 	fputs(_(" -N, --task <tid>       use alternative namespace (/proc/<tid>/mountinfo file)\n"), out);
 	fputs(_(" -n, --noheadings       don't print column headings\n"), out);
-	fputs(_(" -U, --uniq             ignore filesystems with duplicate target\n"), out);
-	fputs(_(" -u, --notruncate       don't truncate text in columns\n"), out);
 	fputs(_(" -O, --options <list>   limit the set of filesystems by mount options\n"), out);
 	fputs(_(" -o, --output <list>    the output columns to be shown\n"), out);
 	fputs(_(" -P, --pairs            use key=\"value\" output format\n"), out);
-	fputs(_(" -r, --raw              use raw output format\n"), out);
-	fputs(_(" -t, --types <list>     limit the set of filesystems by FS types\n"), out);
-	fputs(_(" -v, --nofsroot         don't print [/dir] for bind or btrfs mounts\n"), out);
 	fputs(_(" -R, --submounts        print all submounts for the matching filesystems\n"), out);
+	fputs(_(" -r, --raw              use raw output format\n"), out);
 	fputs(_(" -S, --source <string>  the device to mount (by name, maj:min, \n"
 	        "                          LABEL=, UUID=, PARTUUID=, PARTLABEL=)\n"), out);
 	fputs(_(" -T, --target <string>  the mountpoint to use\n"), out);
+	fputs(_(" -t, --types <list>     limit the set of filesystems by FS types\n"), out);
+	fputs(_(" -U, --uniq             ignore filesystems with duplicate target\n"), out);
+	fputs(_(" -u, --notruncate       don't truncate text in columns\n"), out);
+	fputs(_(" -v, --nofsroot         don't print [/dir] for bind or btrfs mounts\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
-- 
1.7.0.4

