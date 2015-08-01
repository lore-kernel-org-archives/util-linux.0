Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:55754 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750989AbbHAIYG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 1 Aug 2015 04:24:06 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/7] mount: remove duplications of --help and --version from usage text
Date: Sat,  1 Aug 2015 10:23:09 +0200
Message-Id: <1438417391-2269-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1438417391-2269-1-git-send-email-bensberg@justemail.net>
References: <1438417391-2269-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And slice up the affected portions.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/mount.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index c650efe..c172d7f 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -732,9 +732,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	" -F, --fork              fork off for each device (use with -a)\n"
 	" -T, --fstab <path>      alternative file to /etc/fstab\n"));
 	fprintf(out, _(
-	" -h, --help              display this help text and exit\n"
-	" -i, --internal-only     don't call the mount.<type> helpers\n"
-	" -l, --show-labels       lists all mounts with LABELs\n"
+	" -i, --internal-only     don't call the mount.<type> helpers\n"));
+	fprintf(out, _(
+	" -l, --show-labels       show also filesystem labels\n"));
+	fprintf(out, _(
 	" -n, --no-mtab           don't write to /etc/mtab\n"));
 	fprintf(out, _(
 	" -o, --options <list>    comma-separated list of mount options\n"
@@ -745,8 +746,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	"     --source <src>      explicitly specifies source (path, label, uuid)\n"
 	"     --target <target>   explicitly specifies mountpoint\n"));
 	fprintf(out, _(
-	" -v, --verbose           say what is being done\n"
-	" -V, --version           display version information and exit\n"
+	" -v, --verbose           say what is being done\n"));
+	fprintf(out, _(
 	" -w, --rw, --read-write  mount the filesystem read-write (default)\n"));
 
 	fputs(USAGE_SEPARATOR, out);
-- 
1.7.0.4

