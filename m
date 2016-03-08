Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34737 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbcCHWfy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 17:35:54 -0500
Received: by mail-wm0-f51.google.com with SMTP id p65so169083587wmp.1
        for <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 14:35:54 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] cal: remove libtermcap arguments to my_tgetstr()
Date: Tue,  8 Mar 2016 22:35:50 +0000
Message-Id: <1457476550-27914-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Missed in commit b4566a8a8d0cf345e637194f9c95091a1ef4dfe0.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index c687c6c..2a53b89 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -108,7 +108,7 @@ static void my_putstring(char *s)
 		fputs(s, stdout);
 }
 
-static const char *my_tgetstr(char *s __attribute__ ((__unused__)), char *ss)
+static const char *my_tgetstr(char *ss)
 {
 	const char *ret = NULL;
 
@@ -288,8 +288,8 @@ int main(int argc, char **argv)
 		if (term) {
 			has_term = setup_terminal(term) == 0;
 			if (has_term) {
-				Senter = my_tgetstr("so", "smso");
-				Sexit = my_tgetstr("se", "rmso");
+				Senter = my_tgetstr("smso");
+				Sexit = my_tgetstr("rmso");
 			}
 		}
 	}
-- 
2.7.2

