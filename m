Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36240 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdFXKsP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 24 Jun 2017 06:48:15 -0400
Received: by mail-wr0-f193.google.com with SMTP id 77so18496311wrb.3
        for <util-linux@vger.kernel.org>; Sat, 24 Jun 2017 03:48:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] script: ensure typescript and timing errors do not break terminal
Date: Sat, 24 Jun 2017 11:48:08 +0100
Message-Id: <20170624104808.11814-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier when typescript file failed new line after the error did not cause
carriage return.  Here is an example how prompt> travels to wrong place:

prompt> script 0500-perms/typescript
Script started, file is 0500-perms/typescript
script: cannot open 0500-perms/typescript: Permission denied
                                                            prompt>

But that wasn't quite as bad as what happen with timing file, that at
failure left terminal to state where a reset(1) run was needed.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index f2fc2f59c..be869654e 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -423,15 +423,27 @@ static void do_io(struct script_control *ctl)
 
 	if ((ctl->typescriptfp =
 	     fopen(ctl->fname, ctl->append ? "a" UL_CLOEXECSTR : "w" UL_CLOEXECSTR)) == NULL) {
+		struct termios rtt;
+
+		rtt = ctl->attrs;
+		tcsetattr(STDIN_FILENO, TCSANOW, &rtt);
 		warn(_("cannot open %s"), ctl->fname);
 		fail(ctl);
 	}
 	if (ctl->timing) {
-		if (!ctl->tname) {
-			if (!(ctl->timingfp = fopen("/dev/stderr", "w" UL_CLOEXECSTR)))
-				err(EXIT_FAILURE, _("cannot open %s"), "/dev/stderr");
-		} else if (!(ctl->timingfp = fopen(ctl->tname, "w" UL_CLOEXECSTR)))
-			err(EXIT_FAILURE, _("cannot open %s"), ctl->tname);
+		char *tname;
+		if (ctl->tname)
+			tname = ctl->tname;
+		else
+			tname = "/dev/stderr";
+		if (!(ctl->timingfp = fopen(tname, "w" UL_CLOEXECSTR))) {
+			struct termios rtt;
+
+			rtt = ctl->attrs;
+			tcsetattr(STDIN_FILENO, TCSANOW, &rtt);
+			warn(_("cannot open %s"), tname);
+			fail(ctl);
+		}
 	}
 
 
-- 
2.13.1

