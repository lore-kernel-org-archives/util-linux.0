Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:47211 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX1b (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:31 -0500
Received: by mail-we0-f172.google.com with SMTP id x10so256927wey.17
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:30 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/14] findmnt: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:04 +0000
Message-Id: <1358897233-6676-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/findmnt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index f6c864f..3089cce 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1050,12 +1050,11 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	" -N, --task <tid>       use alternative namespace (/proc/<tid>/mountinfo file)\n"
 	" -n, --noheadings       don't print column headings\n"
 	" -u, --notruncate       don't truncate text in columns\n"));
-	fprintf(out, _(
-	" -O, --options <list>   limit the set of filesystems by mount options\n"
-	" -o, --output <list>    the output columns to be shown\n"
-	" -P, --pairs            use key=\"value\" output format\n"
-	" -r, --raw              use raw output format\n"
-	" -t, --types <list>     limit the set of filesystems by FS types\n"));
+fputs (_(" -O, --options <list>   limit the set of filesystems by mount options\n"), out);
+fputs (_(" -o, --output <list>    the output columns to be shown\n"), out);
+fputs (_(" -P, --pairs            use key=\"value\" output format\n"), out);
+fputs (_(" -r, --raw              use raw output format\n"), out);
+fputs (_(" -t, --types <list>     limit the set of filesystems by FS types\n"), out);
 	fprintf(out, _(
 	" -v, --nofsroot         don't print [/dir] for bind or btrfs mounts\n"
 	" -R, --submounts        print all submounts for the matching filesystems\n"
-- 
1.8.1.1

