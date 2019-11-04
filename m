Return-Path: <SRS0=kGen=Y4=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869EACA9EB5
	for <util-linux@archiver.kernel.org>; Mon,  4 Nov 2019 20:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5981F20848
	for <util-linux@archiver.kernel.org>; Mon,  4 Nov 2019 20:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfKDUXU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 4 Nov 2019 15:23:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:53718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbfKDUXU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Nov 2019 15:23:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4C84B391
        for <util-linux@vger.kernel.org>; Mon,  4 Nov 2019 20:23:18 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     util-linux@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] blkid: open device in nonblock mode.
Date:   Mon,  4 Nov 2019 21:23:15 +0100
Message-Id: <20191104202315.4879-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When autoclose is set (kernel default but many distributions reverse the
setting) opening a CD-rom device causes the tray to close.

The function of blkid is to report the current state of the device and
not to change it. Hence it should use O_NONBLOCK when opening the
device to avoid closing a CD-rom tray.

blkid is used liberally in scripts so it can potentially interfere with
the user operating the CD-rom hardware.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 libblkid/src/verify.c | 2 +-
 misc-utils/blkid.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/verify.c b/libblkid/src/verify.c
index a78c9f8f2aa4..4bda3fd40cee 100644
--- a/libblkid/src/verify.c
+++ b/libblkid/src/verify.c
@@ -126,7 +126,7 @@ blkid_dev blkid_verify(blkid_cache cache, blkid_dev dev)
 		}
 	}
 
-	fd = open(dev->bid_name, O_RDONLY|O_CLOEXEC);
+	fd = open(dev->bid_name, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
 	if (fd < 0) {
 		DBG(PROBE, ul_debug("blkid_verify: error %m (%d) while "
 					"opening %s", errno,
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index f2583d2b883f..0df9f6b6f29e 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -499,7 +499,7 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 	int rc = 0;
 	static int first = 1;
 
-	fd = open(devname, O_RDONLY|O_CLOEXEC);
+	fd = open(devname, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
 	if (fd < 0) {
 		warn(_("error: %s"), devname);
 		return BLKID_EXIT_NOTFOUND;
-- 
2.23.0

