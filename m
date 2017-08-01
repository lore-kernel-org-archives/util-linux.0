Return-Path: elseifthen@gmx.com
Subject: [PATCH 7/8] hwclock: restore select() timeout warning
To: Karel Zak <kzak@redhat.com>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
 <c2bfd6c4-8499-f90f-5824-d3e96628d3f2@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <b4527a76-55fe-91ab-6587-598048978152@gmx.com>
Date: Tue, 1 Aug 2017 09:35:42 -0400
MIME-Version: 1.0
In-Reply-To: <c2bfd6c4-8499-f90f-5824-d3e96628d3f2@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


hwclock now exits on select(2) timeout so restore the warning.

Reverts commit ab8f402952301106ad0bd5c5a51dc8646d1bff64
 and    commit efc4eaf4229f78f14430d8739ddef2c5101f05cc

Except use warnx(), because select() timeout does not set errno.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index c738076..a660e32 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -288,9 +288,8 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
 			if (0 < rc)
 				ret = 0;
 			else if (rc == 0) {
-				if (ctl->debug)
-					printf(_("select() to %s to wait for clock tick timed out"),
-					       rtc_dev_name);
+				warnx(_("select() to %s to wait for clock tick timed out"),
+				      rtc_dev_name);
 			} else
 				warn(_("select() to %s to wait for clock tick failed"),
 				     rtc_dev_name);
