Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:50677 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbaIFLZF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Sep 2014 07:25:05 -0400
Received: by mail-wi0-f181.google.com with SMTP id e4so548903wiv.14
        for <util-linux@vger.kernel.org>; Sat, 06 Sep 2014 04:25:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/6] renice: disallow --priority <arg> without pid argument
Date: Sat,  6 Sep 2014 12:24:50 +0100
Message-Id: <1410002693-16540-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier a lonely priority with an argument but without pid resulted to no
action and success, when the invocation should have failed.

$ renice --priority 42 ; echo $?
0

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/renice.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index 0605680..2075d40 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -131,14 +131,14 @@ main(int argc, char **argv)
 		}
 	}
 
-	if (argc < 2)
-		usage(stderr);
-
-	if (strcmp(*argv, "-n") == 0 || strcmp(*argv, "--priority") == 0) {
+	if (*argv && (strcmp(*argv, "-n") == 0 || strcmp(*argv, "--priority") == 0)) {
 		argc--;
 		argv++;
 	}
 
+	if (argc < 2)
+		usage(stderr);
+
 	prio = strtol(*argv, &endptr, 10);
 	if (*endptr)
 		usage(stderr);
-- 
2.1.0

