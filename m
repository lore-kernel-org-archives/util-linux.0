Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f50.google.com ([74.125.83.50]:42839 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170Ab3GGTzY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:24 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so2355695eek.23
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:22 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/34] utmpdump: use unlocked io, and avoid use of printf()
Date: Sun,  7 Jul 2013 20:54:24 +0100
Message-Id: <1373226889-3451-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/utmpdump.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index af3f7c0..3febeaf 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -44,6 +44,7 @@
 #include "nls.h"
 #include "xalloc.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 static char *timetostr(const time_t time)
 {
@@ -361,10 +362,14 @@ int main(int argc, char **argv)
 	}
 
 	if (reverse) {
-		fprintf(stderr, _("Utmp undump of %s\n"), filename);
+		fputs(_("Utmp undump of"), stderr);
+		fputs(filename, stderr);
+		fputs("\n", stderr);
 		undump(in, out);
 	} else {
-		fprintf(stderr, _("Utmp dump of %s\n"), filename);
+		fputs(_("Utmp dump of"), stderr);
+		fputs(filename, stderr);
+		fputs("\n", stderr);
 		in = dump(in, filename, follow, out);
 	}
 
-- 
1.8.3.2

