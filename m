Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57626 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938244AbdD0DeJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Apr 2017 23:34:09 -0400
Subject: [PATCH 1/4] hwclock: extra messages for debug only
To: Karel Zak <kzak@redhat.com>
References: <50c7367a-c086-2c18-af81-9f86f1c2560a@gmx.com>
Cc: util-linux@vger.kernel.org, junk@gmx.li
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <568307cd-b67d-0d43-8ac6-d1b7b731330a@gmx.com>
Date: Wed, 26 Apr 2017 23:33:54 -0400
MIME-Version: 1.0
In-Reply-To: <50c7367a-c086-2c18-af81-9f86f1c2560a@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Only print extra save_adjtime() messages in debug mode. This makes
the --test mode output consistent accross functions.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index a98f4e3..31ee8fe 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -919,10 +919,10 @@ static void save_adjtime(const struct hwclock_control *ctl,
 		  (adjtime->local_utc == LOCAL) ? "LOCAL" : "UTC");
 
 	if (ctl->testing) {
-		printf(_
-		       ("Not updating adjtime file because of testing mode.\n"));
-		printf(_("Would have written the following to %s:\n%s"),
-		       ctl->adj_file_name, content);
+		if (ctl->debug){
+			printf(_("Test mode: %s was not updated with:\n%s"),
+			       ctl->adj_file_name, content);
+		}
 		free(content);
 		return;
 	}
