Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.asbjorn.biz ([185.38.24.25]:44769 "EHLO mail.asbjorn.biz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUgG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 19 Aug 2018 16:36:06 -0400
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?=
        <asbjorn@asbjorn.st>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?=
        <asbjorn@asbjorn.st>
Subject: [PATCH 1/2] script: move output limit check to dedicated function
Date: Sun, 19 Aug 2018 17:16:57 +0000
Message-Id: <20180819171658.20285-1-asbjorn@asbjorn.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Asbjørn Sloth Tønnesen <asbjorn@asbjorn.st>
---
 term-utils/script.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 6d5ddd84a..dfea87463 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -414,6 +414,19 @@ static void write_eof_to_shell(struct script_control *ctl)
 	write_to_shell(ctl, &c, sizeof(char));
 }
 
+static void check_output_limit(struct script_control *ctl)
+{
+	if (ctl->maxsz != 0 && ctl->outsz >= ctl->maxsz) {
+		if (!ctl->quiet)
+			printf(_("Script terminated, max output file size "
+				"%"PRIu64" exceeded.\n"), ctl->maxsz);
+
+		DBG(IO, ul_debug("output size %"PRIu64", exceeded limit %"PRIu64,
+			ctl->outsz, ctl->maxsz));
+		done_log(ctl, _("max output size exceeded"));
+	}
+}
+
 static void handle_io(struct script_control *ctl, int fd, int *eof)
 {
 	char buf[BUFSIZ];
@@ -451,13 +464,7 @@ static void handle_io(struct script_control *ctl, int fd, int *eof)
 		DBG(IO, ul_debug(" master --> stdout %zd bytes", bytes));
 		write_output(ctl, buf, bytes);
 
-		/* check output limit */
-		if (ctl->maxsz != 0 && ctl->outsz >= ctl->maxsz) {
-			if (!ctl->quiet)
-				printf(_("Script terminated, max output file size %"PRIu64" exceeded.\n"), ctl->maxsz);
-			DBG(IO, ul_debug("output size %"PRIu64", exceeded limit %"PRIu64, ctl->outsz, ctl->maxsz));
-			done_log(ctl, _("max output size exceeded"));
-		}
+		check_output_limit(ctl);
 	}
 }
 
-- 
2.16.1
