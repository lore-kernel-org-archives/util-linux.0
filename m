Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51230 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285Ab2L1VYA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Dec 2012 16:24:00 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so5000988wgb.35
        for <util-linux@vger.kernel.org>; Fri, 28 Dec 2012 13:23:59 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/4] losetup: fix declarations [smatch scan]
Date: Fri, 28 Dec 2012 21:23:43 +0000
Message-Id: <1356729823-729-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1356729823-729-1-git-send-email-kerolasa@iki.fi>
References: <1356729823-729-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys-utils/losetup.c:309:2: error: 'for' loop initial declarations are only allowed in C99 mode
sys-utils/losetup.c:374:2: error: 'for' loop initial declarations are only allowed in C99 mode

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/losetup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 2765a38..2c81e69 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -302,11 +302,12 @@ static int make_table(struct loopdev_cxt *lc, const char *file,
 {
 	struct stat sbuf, *st = &sbuf;
 	struct tt_line *ln;
+	int i;
 
 	if (!(tt = tt_new_table(0)))
 		errx(EXIT_FAILURE, _("failed to initialize output table"));
 
-	for (int i = 0; i < ncolumns; i++) {
+	for (i = 0; i < ncolumns; i++) {
 		struct colinfo *ci = get_column_info(i);
 
 		if (!tt_define_column(tt, ci->name, ci->whint, ci->flags))
@@ -341,6 +342,8 @@ static int make_table(struct loopdev_cxt *lc, const char *file,
 
 static void usage(FILE *out)
 {
+	size_t i;
+
 	fputs(USAGE_HEADER, out);
 
 	fprintf(out,
@@ -371,7 +374,7 @@ static void usage(FILE *out)
 	fputs(USAGE_VERSION, out);
 
 	fputs(_("\nAvailable --list columns:\n"), out);
-	for (size_t i = 0; i < NCOLS; i++)
+	for (i = 0; i < NCOLS; i++)
 		fprintf(out, " %12s  %s\n", infos[i].name, _(infos[i].help));
 
 	fprintf(out, USAGE_MAN_TAIL("losetup(8)"));
-- 
1.8.0.3

