Return-Path: <SRS0=BLRm=YK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBF3C4CECE
	for <util-linux@archiver.kernel.org>; Thu, 17 Oct 2019 04:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE81020872
	for <util-linux@archiver.kernel.org>; Thu, 17 Oct 2019 04:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tuhh.de header.i=@tuhh.de header.b="fYTB4RJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfJQEvk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Oct 2019 00:51:40 -0400
Received: from smtp1.rz.tu-harburg.de ([134.28.205.38]:34474 "EHLO
        smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfJQEvk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 17 Oct 2019 00:51:40 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Oct 2019 00:51:39 EDT
Received: from mail.tu-harburg.de (mail4.rz.tu-harburg.de [134.28.202.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tuhh.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 46txRp1nr1zxb1
        for <util-linux@vger.kernel.org>; Thu, 17 Oct 2019 06:45:26 +0200 (CEST)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cmz7792@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 46txRp0DYfzJrC3;
        Thu, 17 Oct 2019 06:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2019-42;
        t=1571287526; bh=H+NSxOMwbxN2d9w1viZ3K5t1oSbPRwq22dfENHI+lko=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=fYTB4RJg293JNNMG0hQzSirBtjYndm3mgo4eaGcr8ADrSlC2dWvD7IPmPIy093ir9
         3JmcSxD8x+ZjyoEvkUR3BiEU78s3MAQj2xsOs1dWy/TpNVvfx7kKPN8je+5KYR4C9s
         qb6trKHEgRG6CMEnCuFS3VXKeIhNWDrwihPbzV+M=
From:   =?UTF-8?q?Merlin=20B=C3=BCge?= <merlin.buege@tuhh.de>
To:     util-linux@vger.kernel.org
Cc:     =?UTF-8?q?Merlin=20B=C3=BCge?= <merlin.buege@tuhh.de>
Subject: [PATCH] mount.8: small typo fixes
Date:   Thu, 17 Oct 2019 06:45:22 +0200
Message-Id: <20191017044522.130193-1-merlin.buege@tuhh.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

---
 sys-utils/mount.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 0c55e1b43..7b3f87661 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -149,12 +149,12 @@ or UUID (see the \fB\-L\fR and \fB\-U\fR options below), or its partition label
 or UUID.  Partition identifiers are supported for example for GUID Partition
 Tables (GPT).
 
-The device name of disk partitions are unstable; hardware reconfiguration,
-adding or removing a device can cause change in names. This is reason why it's
-strongly recommended to use filesystem or partition identificators like UUID or
+The device names of disk partitions are unstable; hardware reconfiguration,
+adding or removing a device can cause changes in names. This is the reason why it's
+strongly recommended to use filesystem or partition identifiers like UUID or
 LABEL.
 
-The command \fBlsblk --fs\fR provides overview of filesystems, LABELs and UUIDs
+The command \fBlsblk --fs\fR provides an overview of filesystems, LABELs and UUIDs
 on available block devices.  The command \fBblkid -p <device>\fR provides details about
 a filesystem on the specified device.
 
-- 
2.23.0

