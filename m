Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:53943 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX1r (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:47 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so4717358wgb.1
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:46 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/14] umount: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:10 +0000
Message-Id: <1358897233-6676-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/umount.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index 396052c..e5a8650 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -78,22 +78,19 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fprintf(out, _(
-	" -a, --all               umount all filesystems\n"
-	" -c, --no-canonicalize   don't canonicalize paths\n"
-	" -d, --detach-loop       if mounted loop device, also free this loop device\n"
-	"     --fake              dry run; skip the umount(2) syscall\n"
-	" -f, --force             force unmount (in case of an unreachable NFS system)\n"));
-	fprintf(out, _(
-	" -i, --internal-only     don't call the umount.<type> helpers\n"
-	" -n, --no-mtab           don't write to /etc/mtab\n"
-	" -l, --lazy              detach the filesystem now, and cleanup all later\n"));
-	fprintf(out, _(
-	" -O, --test-opts <list>  limit the set of filesystems (use with -a)\n"
-	" -R, --recursive         recursively unmount a target with all its children\n"
-	" -r, --read-only         In case unmounting fails, try to remount read-only\n"
-	" -t, --types <list>      limit the set of filesystem types\n"
-	" -v, --verbose           say what is being done\n"));
+	fputs(_(" -a, --all               umount all filesystems\n"), out);
+	fputs(_(" -c, --no-canonicalize   don't canonicalize paths\n"), out);
+	fputs(_(" -d, --detach-loop       if mounted loop device, also free this loop device\n"), out);
+	fputs(_("     --fake              dry run; skip the umount(2) syscall\n"), out);
+	fputs(_(" -f, --force             force unmount (in case of an unreachable NFS system)\n"), out);
+	fputs(_(" -i, --internal-only     don't call the umount.<type> helpers\n"), out);
+	fputs(_(" -n, --no-mtab           don't write to /etc/mtab\n"), out);
+	fputs(_(" -l, --lazy              detach the filesystem now, and cleanup all later\n"), out);
+	fputs(_(" -O, --test-opts <list>  limit the set of filesystems (use with -a)\n"), out);
+	fputs(_(" -R, --recursive         recursively unmount a target with all its children\n"), out);
+	fputs(_(" -r, --read-only         In case unmounting fails, try to remount read-only\n"), out);
+	fputs(_(" -t, --types <list>      limit the set of filesystem types\n"), out);
+	fputs(_(" -v, --verbose           say what is being done\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
-- 
1.8.1.1

