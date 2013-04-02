Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:50648 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTnN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:13 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm11so3584690wib.5
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/13] dmesg: fix usage() output consistancy
Date: Tue,  2 Apr 2013 20:42:48 +0100
Message-Id: <1364931777-2645-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Possible facilities and levels are meant to be printed to same file as
the rest of the usage output.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 3387ea4..6c7f7ed 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -254,13 +254,13 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_VERSION, out);
 	fputs(_("\nSupported log facilities:\n"), out);
 	for (i = 0; i < ARRAY_SIZE(level_names); i++)
-		fprintf(stderr, " %7s - %s\n",
+		fprintf(out, " %7s - %s\n",
 			facility_names[i].name,
 			_(facility_names[i].help));
 
 	fputs(_("\nSupported log levels (priorities):\n"), out);
 	for (i = 0; i < ARRAY_SIZE(level_names); i++)
-		fprintf(stderr, " %7s - %s\n",
+		fprintf(out, " %7s - %s\n",
 			level_names[i].name,
 			_(level_names[i].help));
 	fputs(USAGE_SEPARATOR, out);
-- 
1.8.2

