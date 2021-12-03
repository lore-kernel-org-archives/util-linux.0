Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1840CC433F5
	for <util-linux@archiver.kernel.org>; Fri,  3 Dec 2021 16:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244984AbhLCQEN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:04:13 -0500
Received: from foss.arm.com ([217.140.110.172]:50870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235197AbhLCQEN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 3 Dec 2021 11:04:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB3EA1435;
        Fri,  3 Dec 2021 08:00:48 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.3.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9924B3F73B;
        Fri,  3 Dec 2021 08:00:47 -0800 (PST)
From:   =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To:     util-linux@vger.kernel.org
Cc:     =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH] libfdisk: (MBR) recognize EBBR protective partitions
Date:   Fri,  3 Dec 2021 16:59:08 +0100
Message-Id: <20211203155908.6906-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The MBR partition type 0xF8 is used by the Arm EBBR specification for
protective partitions over fixed-location firmware images.

References: https://github.com/ARM-software/ebbr
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
 include/pt-mbr-partnames.h | 1 +
 include/pt-mbr.h           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/pt-mbr-partnames.h b/include/pt-mbr-partnames.h
index 19a345029..9304793db 100644
--- a/include/pt-mbr-partnames.h
+++ b/include/pt-mbr-partnames.h
@@ -101,6 +101,7 @@
 	{0xf1, N_("SpeedStor")},
 	{0xf4, N_("SpeedStor")},	/* SpeedStor large partition */
 	{0xf2, N_("DOS secondary")},	/* DOS 3.3+ secondary */
+	{0xf8, N_("EBBR protective")},	/* Arm EBBR firmware protective partition */
 	{0xfb, N_("VMware VMFS")},
 	{0xfc, N_("VMware VMKCORE")},	/* VMware kernel dump partition */
 	{0xfd, N_("Linux raid autodetect")},/* Linux raid partition with
diff --git a/include/pt-mbr.h b/include/pt-mbr.h
index 0f014cd88..ff658f346 100644
--- a/include/pt-mbr.h
+++ b/include/pt-mbr.h
@@ -199,6 +199,7 @@ enum {
 	MBR_SPEEDSTOR1_PARTITION	= 0xf1,
 	MBR_SPEEDSTOR2_PARTITION	= 0xf4, /* SpeedStor large partition */
 	MBR_DOS_SECONDARY_PARTITION	= 0xf2, /* DOS 3.3+ secondary */
+	MBR_EBBR_PROTECTIVE_PARTITION	= 0xf8, /* Arm EBBR firmware protective partition */
 	MBR_VMWARE_VMFS_PARTITION	= 0xfb,
 	MBR_VMWARE_VMKCORE_PARTITION	= 0xfc, /* VMware kernel dump partition */
 	MBR_LINUX_RAID_PARTITION	= 0xfd, /* Linux raid partition with autodetect using persistent superblock */
-- 
2.33.0

