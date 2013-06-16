Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:57740 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3FPSyG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:06 -0400
Received: by mail-wi0-f176.google.com with SMTP id ey16so1660894wid.3
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/15] renice: exit with non-zero value when arguments cause warnings
Date: Sun, 16 Jun 2013 19:53:42 +0100
Message-Id: <1371408836-16663-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This commit also fixes potential error counter wrap, which theoretically
could make command to exit with a success when it internally failed just
correct amount of times.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/renice.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index 50b1642..c0378e1 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -138,6 +138,7 @@ main(int argc, char **argv)
 
 			if (pwd == NULL) {
 				warnx(_("unknown user %s"), *argv);
+				errs = 1;
 				continue;
 			}
 			who = pwd->pw_uid;
@@ -145,10 +146,11 @@ main(int argc, char **argv)
 			who = strtol(*argv, &endptr, 10);
 			if (who < 0 || *endptr) {
 				warnx(_("bad value %s"), *argv);
+				errs = 1;
 				continue;
 			}
 		}
-		errs += donice(which, who, prio);
+		errs |= donice(which, who, prio);
 	}
 	return errs != 0 ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
1.8.3.1

