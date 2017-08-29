Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:59614 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbdH2QfO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 29 Aug 2017 12:35:14 -0400
Subject: [PATCH 3/3] hwclock: close hwaudit_fd unconditionally
To: Karel Zak <kzak@redhat.com>
References: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9397486e-e8a1-0668-dcec-cc479a1ac500@gmx.com>
Date: Tue, 29 Aug 2017 12:35:02 -0400
MIME-Version: 1.0
In-Reply-To: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 6f868df..81ede0a 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1376,8 +1376,8 @@ hwclock_exit(int status)
 		audit_log_user_message(hwaudit_fd, AUDIT_USYS_CONFIG,
 				       "op=change-system-time", NULL, NULL, NULL,
 				       status);
-		close(hwaudit_fd);
 	}
+	close(hwaudit_fd);
 #endif
 	exit(status);
 }
