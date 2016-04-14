Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37292 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbcDNUWQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Apr 2016 16:22:16 -0400
Received: by mail-wm0-f52.google.com with SMTP id n3so4484843wmn.0
        for <util-linux@vger.kernel.org>; Thu, 14 Apr 2016 13:22:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] script: close file descriptors on exec
Date: Thu, 14 Apr 2016 21:22:05 +0100
Message-Id: <1460665325-7793-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The commands spawned from script(1) will never need access various file
descriptors the script(1) is using.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 1199742..88b522a 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -419,15 +419,15 @@ static void do_io(struct script_control *ctl)
 	};
 
 
-	if ((ctl->typescriptfp = fopen(ctl->fname, ctl->append ? "a" : "w")) == NULL) {
+	if ((ctl->typescriptfp = fopen(ctl->fname, ctl->append ? "ae" : "we")) == NULL) {
 		warn(_("cannot open %s"), ctl->fname);
 		fail(ctl);
 	}
 	if (ctl->timing) {
 		if (!ctl->tname) {
-			if (!(ctl->timingfp = fopen("/dev/stderr", "w")))
+			if (!(ctl->timingfp = fopen("/dev/stderr", "we")))
 				err(EXIT_FAILURE, _("cannot open %s"), "/dev/stderr");
-		} else if (!(ctl->timingfp = fopen(ctl->tname, "w")))
+		} else if (!(ctl->timingfp = fopen(ctl->tname, "we")))
 			err(EXIT_FAILURE, _("cannot open %s"), ctl->tname);
 	}
 
@@ -515,7 +515,7 @@ static void getslave(struct script_control *ctl)
 {
 #ifndef HAVE_LIBUTIL
 	ctl->line[strlen("/dev/")] = 't';
-	ctl->slave = open(ctl->line, O_RDWR);
+	ctl->slave = open(ctl->line, O_RDWR | O_CLOEXEC);
 	if (ctl->slave < 0) {
 		warn(_("cannot open %s"), ctl->line);
 		fail(ctl);
@@ -625,7 +625,7 @@ static void getmaster(struct script_control *ctl)
 			break;
 		for (cp = "0123456789abcdef"; *cp; cp++) {
 			*pty = *cp;
-			ctl->master = open(ctl->line, O_RDWR);
+			ctl->master = open(ctl->line, O_RDWR | O_CLOEXEC);
 			if (ctl->master >= 0) {
 				char *tp = &ctl->line[strlen("/dev/")];
 				int ok;
@@ -765,7 +765,7 @@ int main(int argc, char **argv)
 	 * handled according to their default dispositions */
 	sigprocmask(SIG_BLOCK, &ctl.sigset, &ctl.sigorg);
 
-	if ((ctl.sigfd = signalfd(-1, &ctl.sigset, 0)) < 0)
+	if ((ctl.sigfd = signalfd(-1, &ctl.sigset, SFD_CLOEXEC)) < 0)
 		err(EXIT_FAILURE, _("cannot set signal handler"));
 
 	DBG(SIGNAL, ul_debug("signal fd=%d", ctl.sigfd));
-- 
2.8.0

