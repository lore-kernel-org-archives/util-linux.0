Return-Path: <SRS0=WsHy=7S=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98886C433DF
	for <util-linux@archiver.kernel.org>; Fri,  5 Jun 2020 05:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB21207D5
	for <util-linux@archiver.kernel.org>; Fri,  5 Jun 2020 05:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F4xmJebf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgFEFGV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:06:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58517 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEFGU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 5 Jun 2020 01:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591333580; x=1622869580;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2bZQ148WLR6aiFzQviyHqT2uu8S98MVOwSV0G4fpRw0=;
  b=F4xmJebfmEuOmJMWDzYkJr4xR21kJomN0XvjxAvxCzpaZeRJSO+aQkP7
   PVEuMROc+swrJMqVhFU3OinfPUO0e8BdErIFqSWvIt9ip38DB1/JnmKkN
   uKYXJmkC0uag+Rpudz1orKELKBUwF+2wueOjfCUQZdASoYJi+eaFqXt7g
   MThOx8Uz2igR7mutXVGog8c5cm8nSzc8GUZ/F6Nc9ajpaRFUL6uMWH6p/
   zsduz2C5J43OCMHYn1gEKBiYQpUK5A1h0ff/n74+Fliy5p6pW9uYqPlZd
   +x8x9osY0c4/8n4SMtjNKvxcDpkqxCtqk9B85+FiHfDPYmYmlViFwpElq
   g==;
IronPort-SDR: NfvZ5CxCNQsxPJeRQpYhTmo2gSoBrrSjAjcZuywBBiF9hnXUyDFSjf/eUjyws4gYtAxu4mU5w2
 ptd+XSB7IBXJvaTDo1nHdBo48VaZUP/96+w6wEMdJlqw+WcyU++07misjzX29l5R7L2Odvn1QH
 7Hqp6p4pQJ5eNSyfoYxy3+9noQRCm9z61lzi1/U5AYCRe5nFxtp0UX9TcYbAjVKPZSyn3lD1rg
 6XcwhktwXOXf1oruq7ShuHevsTByVT7uy8bZyZ2gJpN0mpSuVE3mOUZNUsXKOYaJQedmKJGfjR
 yCQ=
X-IronPort-AV: E=Sophos;i="5.73,475,1583164800"; 
   d="scan'208";a="248368939"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 13:06:19 +0800
IronPort-SDR: g7IVQo9LE0JTAgK3LueIyLNtp7qkw6TwOfA06J9+bJ3VkBWC+7LiJ7DaRQuORiKoYo+ysEM4MR
 GWK4nnu0sXLYc6P4UalzxEu+OCqRCLhdU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 21:55:55 -0700
IronPort-SDR: 75LdCxh9ryhQAvAY7ZaH6RckvETrzSBsuO+C8GNofA9U0RUdeTNlohIqHIz5wll5uZE4oZFjxi
 MHfaql66qO6A==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Jun 2020 22:06:19 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] blkzone: Add --force option
Date:   Fri,  5 Jun 2020 14:06:18 +0900
Message-Id: <20200605050618.591153-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Commit 7a2602f629fe ("blkzone: deny destructive ioctls on busy blockdev")
introduced exclusive mode to open block devices to submit zone management
ioctls. This avoids unintended status change of block devices used by the
system. However, it makes blkzone less usable for testing. For example,
the test case zbd/007 of blktests utilizes blkzone to reset zones of
block devices mapped to dm-linear devices. After the commit, the test
case fails with EBUSY error at blkzone reset, since the system uses the
reset target block device to map to the dm-linear device.

To allow blkzone to change status of zoned block devices used by the
system with intention, introduce --force option. With this option, block
devices are opened without exclusive mode.

Also fix missing initialization and too many periods in man page of
--verbose option.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 sys-utils/blkzone.8 |  5 ++++-
 sys-utils/blkzone.c | 17 ++++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/sys-utils/blkzone.8 b/sys-utils/blkzone.8
index f50e3f5df..64ad23bb3 100644
--- a/sys-utils/blkzone.8
+++ b/sys-utils/blkzone.8
@@ -107,9 +107,12 @@ The maximum number of zones the command should operate on. The default value
 is the number of zones starting from \fIoffset\fR. This option cannot be
 used together with the option \fB\-\-length\fP.
 .TP
+.BR \-f , " \-\-force"
+Enforce commands to change zone status on block devices used by the system.
+.TP
 .BR \-v , " \-\-verbose"
 Display the number of zones returned in the report or the range of sectors
-reset..
+reset.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
index 62430e634..5c170127b 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -81,6 +81,7 @@ struct blkzone_control {
 	uint64_t length;
 	uint32_t count;
 
+	unsigned int force : 1;
 	unsigned int verbose : 1;
 };
 
@@ -295,13 +296,16 @@ static int blkzone_action(struct blkzone_control *ctl)
 	struct blk_zone_range za = { .sector = 0 };
 	unsigned long zonesize;
 	uint64_t zlen;
-	int fd;
+	int fd, mode;
 
 	zonesize = blkdev_chunk_sectors(ctl->devname);
 	if (!zonesize)
 		errx(EXIT_FAILURE, _("%s: unable to determine zone size"), ctl->devname);
 
-	fd = init_device(ctl, O_WRONLY | O_EXCL);
+	mode = O_WRONLY;
+	if (!ctl->force)
+		mode |= O_EXCL;
+	fd = init_device(ctl, mode);
 
 	if (ctl->offset & (zonesize - 1))
 		errx(EXIT_FAILURE, _("%s: offset %" PRIu64 " is not aligned "
@@ -362,6 +366,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -o, --offset <sector>  start sector of zone to act (in 512-byte sectors)\n"), out);
 	fputs(_(" -l, --length <sectors> maximum sectors to act (in 512-byte sectors)\n"), out);
 	fputs(_(" -c, --count <number>   maximum number of zones\n"), out);
+	fputs(_(" -f, --force            enforce on block devices used by the system\n"), out);
 	fputs(_(" -v, --verbose          display more details\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	printf(USAGE_HELP_OPTIONS(24));
@@ -382,12 +387,15 @@ int main(int argc, char **argv)
 		.count = 0,
 		.length = 0
 	};
+	ctl.force = 0;
+	ctl.verbose = 0;
 
 	static const struct option longopts[] = {
 	    { "help",    no_argument,       NULL, 'h' },
 	    { "count",   required_argument, NULL, 'c' }, /* max #of zones to operate on */
 	    { "length",  required_argument, NULL, 'l' }, /* max of sectors to operate on */
 	    { "offset",  required_argument, NULL, 'o' }, /* starting LBA */
+	    { "force", no_argument,         NULL, 'f' },
 	    { "verbose", no_argument,       NULL, 'v' },
 	    { "version", no_argument,       NULL, 'V' },
 	    { NULL, 0, NULL, 0 }
@@ -412,7 +420,7 @@ int main(int argc, char **argv)
 		argc--;
 	}
 
-	while ((c = getopt_long(argc, argv, "hc:l:o:vV", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "hc:l:o:fvV", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -429,6 +437,9 @@ int main(int argc, char **argv)
 			ctl.offset = strtosize_or_err(optarg,
 					_("failed to parse zone offset"));
 			break;
+		case 'f':
+			ctl.force = 1;
+			break;
 		case 'v':
 			ctl.verbose = 1;
 			break;
-- 
2.25.4

