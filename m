Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38008 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbcCNViv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Mar 2016 17:38:51 -0400
Received: by mail-wm0-f54.google.com with SMTP id l68so1218598wml.1
        for <util-linux@vger.kernel.org>; Mon, 14 Mar 2016 14:38:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] vipw: print only one new line when asking about shadow file
Date: Mon, 14 Mar 2016 21:38:30 +0000
Message-Id: <1457991510-12122-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 11b86e1733 changed printf() to puts() in favour of more simple
function, but forgot that puts() adds a new line to end of string.  That new
line is neither needed, or expected, so use fputs() that is both a simple
printing function and comes without new line side effect.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/vipw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index b8e5b47..0438656 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -343,9 +343,9 @@ int main(int argc, char *argv[])
 	if (access(orig_file, F_OK) == 0) {
 		char response[80];
 
-		puts((program == VIGR)
+		fputs((program == VIGR)
 		       ? _("You are using shadow groups on this system.\n")
-		       : _("You are using shadow passwords on this system.\n"));
+		       : _("You are using shadow passwords on this system.\n"), stdout);
 
 		/* TRANSLATORS: this program uses for y and n rpmatch(3),
 		 * which means they can be translated. */
-- 
2.7.3

