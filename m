Return-Path: <SRS0=LCHA=5K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C242EC54FCF
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946E620719
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 15:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YqhkwCOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgCYPKP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:10:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12381 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgCYPKO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 25 Mar 2020 11:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585149014; x=1616685014;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Rj8+3IbP2PzDgRlYfvD0+j+Qr0oAfsRoVy5PQxsbiE=;
  b=YqhkwCOxJ3Qkfp2gloTlDtOO4tRwdyXG8nmUb9HQ6F4rMkYzLHuLNA34
   CcLHnWxX/zp7+6RKNwuCOCv4w3TgnbKmstvbsgv1KCOLJDHC5M/QCOaCK
   vbRqqUH3HXmfGhEz9LMQES2p0slTDfNmohhMNeNwGIuI7rev2v9sb6n7K
   +vPaSxOX1+n5Qb9vXtROV/hjRfLolBIpyG2BTPQhSbXm9uaK/kZKDdknU
   1GgdDAkBcgMqKODpjY3qL/jkMceYG+CzoQB1b3rMFYnpjkPSKlQsSrRed
   Oz74cA0l/BKv4fsZ+Mj7wsH56/QmQ6wM4gnD3vt3JaCDTbRlkLRNLIehN
   g==;
IronPort-SDR: W/Z6nZCCwH1NZQ9I1wdjddpCIGOHUMOybsJ6p9E1g0U1ljlTRpIpzUUkTeBODt5Y4ShXWTNOGs
 d/NQkEN4FwS4OZd0MXbte7Yp4pVLfJrm7szZdGyHMOsCfg1XelUqF+SRKp4ipraJD5GcRUvHKL
 sXH68lBMklHxSD4RYSGh3lumZblq1aYb9+GtQEixiU8E2B/dye8LKZuCD/RQG546zwXAa5IZft
 hBZMtTXkkP7EnNfzxPZALaQGxdJYThqGM6I0nXfElNe4SIC3M33oAPy/uMf5VyDQA3k0FXJd9J
 mwg=
X-IronPort-AV: E=Sophos;i="5.72,304,1580745600"; 
   d="scan'208";a="133913548"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 23:09:54 +0800
IronPort-SDR: IG54wfuBWjC9EAEaw5fEx0bzWyJteUmp3vEeVW14rwQKZSR6KwENijGHSNh3BnDVyJZy17x7qJ
 dh0YHier0bkSkN9fvyDb79puEZuToJti0Z1Nvx388Y4NImOX4xf5n19b6WvX5g2ahHqoqJvA8l
 46pbgx9y+qkGWr+S8lxmgfjmpPz7KcmEhHE3npeMO6dCLnZ/FmJ4gJ8FFgeErdGLnj9Lz4T4yI
 NLw2K9dBEx2Qarx3SC6sEHDoTcjPz/zxlXDPOh+A8Sv5chLVX6Xq2foFTu/pD7VXQdrvhT/EiB
 sky5057BU54AwX1lrp9Zj+lZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 08:01:31 -0700
IronPort-SDR: +yKBAOd3lVWhJTaHY4NpKZshaQECapXduYrA2QfDU8DMiVtG7aJUtfYQA5IHvjNqa95zetJ9Vt
 s/jlOkYFnUTYeerfKbcxbrTYloNksxxc/BUbmEVD/YfYkpAbYD/s4Ye04UHyyIMq1IqTBQvjjv
 +bHyeIrC0lNJUE3MOGRdtrkvKI0k+zUJ5to4WGm2EpYyTcTJkkQbGPKF44E/tgISR4ADxqt1tu
 hQRBvUBoxzxhyMNN/AVYZDvvKdBD2R/V0z09Aqcc5Xhzd4/WKvSf43bCuyxumP1DyTAAWui/ww
 xB8=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Mar 2020 08:09:54 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@justemail.net>
Cc:     Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmnerg <Hans.Holmberg@wdc.com>
Subject: [PATCH v3] blkzone: add open/close/finish commands
Date:   Thu, 26 Mar 2020 00:09:52 +0900
Message-Id: <20200325150952.326707-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Aravind Ramesh <Aravind.Ramesh@wdc.com>

Introduce blkzone open, close and finish commands, issuing BLKOPENZONE,
BLKCLOSEZONE and BLKFINISHZONE ioctl commands to open, close or finish
a range of zones of a zoned block device.

Since these three commands are similar to the existing zone reset
command, the existing zone reset command implementation is changed into
the generic blkzone_action() internal handler function for processing
all zone actions.

The BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl commands codes are
defined in linux/blkzoned.h starting with kernel version 5.5. To ensure
that the blkzone utility compiles even with older blkzoned.h kernel
header versions, these ioctl commands are internally defined if the
blkzoned.h header definition is not present. Execution of these commands
on kernels older than 5.5 will result in a -ENOTTY error (missing
ioctl).

Signed-off-by: Aravind Ramesh <Aravind.Ramesh@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 sys-utils/blkzone.8 | 27 +++++++++++++++++---
 sys-utils/blkzone.c | 61 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/sys-utils/blkzone.8 b/sys-utils/blkzone.8
index 83d3dd7ce..f50e3f5df 100644
--- a/sys-utils/blkzone.8
+++ b/sys-utils/blkzone.8
@@ -55,10 +55,31 @@ x?:Reserved conditions (should not be reported)
 The command \fBblkzone reset\fP is used to reset one or more zones. Unlike
 .BR sg_reset_wp (8),
 this command operates from the block layer and can reset a range of zones.
+
+.SS open
+The command \fBblkzone open\fP is used to explicitly open one or more zones.
+Unlike
+.BR sg_zone (8),
+open action, this command operates from the block layer and can open a range
+of zones.
+
+.SS close
+The command \fBblkzone close\fP is used to close one or more zones. Unlike
+.BR sg_zone (8),
+close action, this command operates from the block layer and can close a range
+of zones.
+
+.SS finish
+The command \fBblkzone finish\fP is used to finish (transition to full condition)
+one or more zones. Unlike
+.BR sg_zone (8),
+finish action, this command operates from the block layer and can finish a range
+of zones.
+
 .PP
-By default, the command will operate from the zone at device
-sector 0 and reset all zones. Options may be used to modify this behavior
-as well as specify the operation to be performed on the zone, as explained below.
+By default, the reset, open, close and finish commands will operate from the zone
+at device sector 0 and operate on all zones. Options may be used to modify this
+behavior as explained below.
 
 .SH OPTIONS
 The
diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
index 715f03fef..d2670f63e 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -44,14 +44,29 @@
 #include "sysfs.h"
 #include "optutils.h"
 
+/*
+ * These ioctls are defined in linux/blkzoned.h starting with kernel 5.5.
+ */
+#ifndef BLKOPENZONE
+#define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
+#endif
+#ifndef BLKCLOSEZONE
+#define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
+#endif
+#ifndef BLKFINISHZONE
+#define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
+#endif
+
 struct blkzone_control;
 
 static int blkzone_report(struct blkzone_control *ctl);
-static int blkzone_reset(struct blkzone_control *ctl);
+static int blkzone_action(struct blkzone_control *ctl);
 
 struct blkzone_command {
 	const char *name;
 	int (*handler)(struct blkzone_control *);
+	unsigned long ioctl_cmd;
+	const char *ioctl_name;
 	const char *help;
 };
 
@@ -70,8 +85,36 @@ struct blkzone_control {
 };
 
 static const struct blkzone_command commands[] = {
-	{ "report",	blkzone_report, N_("Report zone information about the given device") },
-	{ "reset",	blkzone_reset,  N_("Reset a range of zones.") }
+	{
+		"report",
+		blkzone_report,
+		0, NULL,
+		N_("Report zone information about the given device")
+	},
+	{
+		"reset",
+		blkzone_action,
+		BLKRESETZONE, "BLKRESETZONE",
+		N_("Reset a range of zones.")
+	},
+	{
+		"open",
+		blkzone_action,
+		BLKOPENZONE, "BLKOPENZONE",
+		N_("Open a range of zones.")
+	},
+	{
+		"close",
+		blkzone_action,
+		BLKCLOSEZONE, "BLKCLOSEZONE",
+		N_("Close a range of zones.")
+	},
+	{
+		"finish",
+		blkzone_action,
+		BLKFINISHZONE, "BLKFINISHZONE",
+		N_("Set a range of zones to Full.")
+	}
 };
 
 static const struct blkzone_command *name_to_command(const char *name)
@@ -246,9 +289,9 @@ static int blkzone_report(struct blkzone_control *ctl)
 }
 
 /*
- * blkzone reset
+ * blkzone reset, open, close, and finish.
  */
-static int blkzone_reset(struct blkzone_control *ctl)
+static int blkzone_action(struct blkzone_control *ctl)
 {
 	struct blk_zone_range za = { .sector = 0 };
 	unsigned long zonesize;
@@ -288,11 +331,13 @@ static int blkzone_reset(struct blkzone_control *ctl)
 	za.sector = ctl->offset;
 	za.nr_sectors = zlen;
 
-	if (ioctl(fd, BLKRESETZONE, &za) == -1)
-		err(EXIT_FAILURE, _("%s: BLKRESETZONE ioctl failed"), ctl->devname);
+	if (ioctl(fd, ctl->command->ioctl_cmd, &za) == -1)
+		err(EXIT_FAILURE, _("%s: %s ioctl failed"),
+		    ctl->devname, ctl->command->ioctl_name);
 	else if (ctl->verbose)
-		printf(_("%s: successfully reset in range from %" PRIu64 ", to %" PRIu64),
+		printf(_("%s: successfull %s of zones in range from %" PRIu64 ", to %" PRIu64),
 			ctl->devname,
+			ctl->command->name,
 			ctl->offset,
 			ctl->offset + zlen);
 	close(fd);
-- 
2.25.1

