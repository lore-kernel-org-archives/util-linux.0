Return-Path: <SRS0=M7Df=5J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE484C10DCE
	for <util-linux@archiver.kernel.org>; Tue, 24 Mar 2020 05:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754A820663
	for <util-linux@archiver.kernel.org>; Tue, 24 Mar 2020 05:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HX/Vi2vL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCXFaV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:30:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7598 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCXFaV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 24 Mar 2020 01:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585027820; x=1616563820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R8IebJsYa3P0wy9vXxX7OOn1roRDTk48DnQs6E8RoCQ=;
  b=HX/Vi2vL+KF35Q/cBl0+5KWVypwcU6Sj1SaPBd0X4jWxcN87pG9a3XU4
   mNiId252qK0fZrxlIRg/k8MYSS3Fv49UbHeMrIneFgfcVXxyXZY9hyJ9x
   Be5pN4kp7FJQh9gWEKmo4ZFxC7zWrJIBvsQC9T4RvGuaMh8DaR39cqt+k
   p8yBCzQp4BwE8kcKy7g1kHb82xkA5IoQ+rsKgaG51UCta+q0vyzpupsnr
   tDYg3v57Rcdhd+IyoQQlmRzBKP7I/p4ggiB/3lejhiksdQvV0rrXBXy3k
   n16auJJLmdspVZARn+U13IpFr1VJQ1MzfaXlF9mGp2a4ugyyUzGtHZA40
   A==;
IronPort-SDR: PYb+RxI8qUXfA0P1/bm+Lzb2vpne46uPiX/pfTIHBgnveLt08szb0MvYfQv+cx8WV+eLW4QCKD
 caeO2hdbldlgk5T9vZhTChsh6MRPXqDoJ1lLaEAfMjSwVdAIzpGYSVBKvqKR5jlcIpTa2uT8Vy
 J0j+ZyCHqrOEKPeQqIYOE6aZRF3dc2oas4qtdZJjb3/h6qcb/06NLPNUN61LOHuQGKaRb6VMDa
 4KAzFqZMiNC6ArINjuFCzSSKVwZJtdVvnFzhyhNGGOoUTFvPMV56YNGt0tYl36gmpNnbLgz5sl
 GRs=
X-IronPort-AV: E=Sophos;i="5.72,299,1580745600"; 
   d="scan'208";a="241797166"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 13:30:20 +0800
IronPort-SDR: NiH1agOJW3Olt10ZOkiJLLAZgEMgCFD2SeLgqXIUixYVzSy9Q8yItbkYsP5wq6QRTxl59UYcpr
 +HopwjZrXsz82GVElBUcuoo3AxPjOYEPlB0NJ/vdchbNTCTXwjcjpqoThkOXojCBRBKmQtawLY
 jimd63x3ziPYB2n+2G9jZN23F0reZfmph3K3G2tUihSm5t5iPNpLU99sWcfF8BkBqqK8hcAGlT
 2j1FLGI0xxYMmOSoalwQtZsBSCrEpet8M33vr74zZQ3zrye6R1jdLZ+8vIqWgIad4WOek5IfSy
 ke0Ro2cpAxTc6j2LdysoTz/Q
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 22:22:00 -0700
IronPort-SDR: /+/o9tgx1XnMS3Yr6pRRPGsKKIZ+vQj7Q52c2bkDIiIYyCdmSeez/w4pctUE4SjCAdfm5OzEQj
 fcnOQevBEHBH39KVx5FkaJKLEGPejOLlGbsOrGYcLCYlblHqWvISGysEq8g8gOB79hIVjjpiyq
 Ep14cZwQjfHNjW3ZBj/weJZxbHdzyQNdg7tXOev+WAbPIK3Jg2H+TQT76bskquRD9hYnWCmfjY
 uWvYdIggJ1aO5QTl9cf1ph4EfP3K3G1+hsWrxGl4H9aL1ZDO4hl55fBXQyZ8YmyZ+v4P44BCMc
 wVI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Mar 2020 22:30:20 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@justemail.net>
Cc:     Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmnerg <Hans.Holmberg@wdc.com>
Subject: [PATCH] blkzone: add open/close/finish commands
Date:   Tue, 24 Mar 2020 14:30:18 +0900
Message-Id: <20200324053018.18878-1-damien.lemoal@wdc.com>
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
Tested-by: Hans Holmnerg <Hans.Holmberg@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 sys-utils/blkzone.8 | 27 +++++++++++++++--
 sys-utils/blkzone.c | 74 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 91 insertions(+), 10 deletions(-)

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
index 715f03fef..b862aa67d 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -44,10 +44,23 @@
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
@@ -71,9 +84,28 @@ struct blkzone_control {
 
 static const struct blkzone_command commands[] = {
 	{ "report",	blkzone_report, N_("Report zone information about the given device") },
-	{ "reset",	blkzone_reset,  N_("Reset a range of zones.") }
+	{ "reset",	blkzone_action, N_("Reset a range of zones.") },
+	{ "open",	blkzone_action, N_("Open a range of zones.") },
+	{ "close",	blkzone_action, N_("Close a range of zones.") },
+	{ "finish",	blkzone_action, N_("Set a range of zones to Full.") }
+};
+
+/*
+ * The action values must match the command index in the command array.
+ */
+enum blkzone_action {
+	BLK_ZONE_NO_ACTION = 0,
+	BLK_ZONE_RESET,
+	BLK_ZONE_OPEN,
+	BLK_ZONE_CLOSE,
+	BLK_ZONE_FINISH,
 };
 
+static enum blkzone_action command_action(const struct blkzone_command *command)
+{
+	return command - &commands[0];
+}
+
 static const struct blkzone_command *name_to_command(const char *name)
 {
 	size_t i;
@@ -246,15 +278,41 @@ static int blkzone_report(struct blkzone_control *ctl)
 }
 
 /*
- * blkzone reset
+ * blkzone reset, open, close, and finish.
  */
-static int blkzone_reset(struct blkzone_control *ctl)
+
+static int blkzone_action(struct blkzone_control *ctl)
 {
 	struct blk_zone_range za = { .sector = 0 };
 	unsigned long zonesize;
+	unsigned long ioctl_cmd;
+	const char *ioctl_name;
 	uint64_t zlen;
 	int fd;
 
+	switch (command_action(ctl->command)) {
+	case BLK_ZONE_RESET:
+		ioctl_cmd = BLKRESETZONE;
+		ioctl_name = "BLKRESETZONE";
+		break;
+	case BLK_ZONE_OPEN:
+		ioctl_cmd = BLKOPENZONE;
+		ioctl_name = "BLKOPENZONE";
+		break;
+	case BLK_ZONE_CLOSE:
+		ioctl_cmd = BLKCLOSEZONE;
+		ioctl_name = "BLKCLOSEZONE";
+		break;
+	case BLK_ZONE_FINISH:
+		ioctl_cmd = BLKFINISHZONE;
+		ioctl_name = "BLKFINISHZONE";
+		break;
+	case BLK_ZONE_NO_ACTION:
+		/* fallthrough */
+	default:
+		errx(EXIT_FAILURE, _("Invalid zone action"));
+	}
+
 	zonesize = blkdev_chunk_sectors(ctl->devname);
 	if (!zonesize)
 		errx(EXIT_FAILURE, _("%s: unable to determine zone size"), ctl->devname);
@@ -288,11 +346,13 @@ static int blkzone_reset(struct blkzone_control *ctl)
 	za.sector = ctl->offset;
 	za.nr_sectors = zlen;
 
-	if (ioctl(fd, BLKRESETZONE, &za) == -1)
-		err(EXIT_FAILURE, _("%s: BLKRESETZONE ioctl failed"), ctl->devname);
+	if (ioctl(fd, ioctl_cmd, &za) == -1)
+		err(EXIT_FAILURE, _("%s: %s ioctl failed"),
+		    ctl->devname, ioctl_name);
 	else if (ctl->verbose)
-		printf(_("%s: successfully reset in range from %" PRIu64 ", to %" PRIu64),
+		printf(_("%s: successfully %s zones in range from %" PRIu64 ", to %" PRIu64),
 			ctl->devname,
+			ctl->command->name,
 			ctl->offset,
 			ctl->offset + zlen);
 	close(fd);
-- 
2.25.1

