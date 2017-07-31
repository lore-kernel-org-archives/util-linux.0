Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:57550 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbdGaXir (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 31 Jul 2017 19:38:47 -0400
Subject: [PATCH 2/5] hwclock: squash custom errno strings
To: Karel Zak <kzak@redhat.com>
References: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <0f1679b3-63c3-aa19-5a4e-b752c19094f7@gmx.com>
Date: Mon, 31 Jul 2017 19:38:40 -0400
MIME-Version: 1.0
In-Reply-To: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


warn() appends ENOENT as: No such file or directory

The custom string is unnecessary and problematic for translators.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 2af2666..36ce397 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -402,10 +402,7 @@ int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch_p)
 
 	rtc_fd = open_rtc(ctl);
 	if (rtc_fd < 0) {
-		if (errno == ENOENT)
-			warnx(_("%s does not exist."), rtc_dev_name);
-		else
-			warn(_("cannot open %s"), rtc_dev_name);
+		warn(_("cannot open %s"), rtc_dev_name);
 		return 1;
 	}
 
@@ -440,10 +437,7 @@ int set_epoch_rtc(const struct hwclock_control *ctl)
 
 	rtc_fd = open_rtc(ctl);
 	if (rtc_fd < 0) {
-		if (errno == ENOENT)
-			warnx(_("%s does not exist."), rtc_dev_name);
-		else
-			warn(_("cannot open %s"), rtc_dev_name);
+		warn(_("cannot open %s"), rtc_dev_name);
 		return 1;
 	}
 
