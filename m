Return-Path: <SRS0=OPDR=BC=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EB0C4345E
	for <util-linux@archiver.kernel.org>; Thu, 23 Jul 2020 22:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF59120737
	for <util-linux@archiver.kernel.org>; Thu, 23 Jul 2020 22:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGWWbp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:31:45 -0400
Received: from vn01.namespace.at ([213.208.148.228]:41236 "EHLO
        nlay-fle-service01.in.namespace.at" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726501AbgGWWbo (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Jul 2020 18:31:44 -0400
Received: from [10.100.0.62] (helo=debbuild.in.namespace.at)
        by nlay-fle-service01.in.namespace.at with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <zeha@debian.org>)
        id 1jyjkc-0065Ox-7h
        for util-linux@vger.kernel.org; Fri, 24 Jul 2020 00:31:42 +0200
Received: from ch by debbuild.in.namespace.at with local (Exim 4.94)
        (envelope-from <zeha@debian.org>)
        id 1jyjkb-0000yr-Um
        for util-linux@vger.kernel.org; Thu, 23 Jul 2020 22:31:41 +0000
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Subject: [PATCH] manpages: fix "The example command" in AVAILABILITY section
Date:   Thu, 23 Jul 2020 22:31:41 +0000
Message-Id: <20200723223141.3718-1-zeha@debian.org>
X-Mailer: git-send-email 2.28.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
---
 disk-utils/fsck.cramfs.8 | 2 +-
 disk-utils/mkfs.cramfs.8 | 2 +-
 misc-utils/uuidparse.1   | 2 +-
 sys-utils/irqtop.1       | 2 +-
 sys-utils/lsirq.1        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/disk-utils/fsck.cramfs.8 b/disk-utils/fsck.cramfs.8
index 1beabd81b..90d794205 100644
--- a/disk-utils/fsck.cramfs.8
+++ b/disk-utils/fsck.cramfs.8
@@ -55,7 +55,7 @@ usage information was printed
 .BR mount (8),
 .BR mkfs.cramfs (8)
 .SH AVAILABILITY
-The example command is part of the util-linux package and is available from
+The fsck.cramfs command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
 Linux Kernel Archive
 .UE .
diff --git a/disk-utils/mkfs.cramfs.8 b/disk-utils/mkfs.cramfs.8
index 63158dd34..f01229f82 100644
--- a/disk-utils/mkfs.cramfs.8
+++ b/disk-utils/mkfs.cramfs.8
@@ -84,7 +84,7 @@ operation error, such as unable to allocate memory
 .BR fsck.cramfs (8),
 .BR mount (8)
 .SH AVAILABILITY
-The example command is part of the util-linux package and is available from
+The mkfs.cramfs command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
 Linux Kernel Archive
 .UE .
diff --git a/misc-utils/uuidparse.1 b/misc-utils/uuidparse.1
index 9194ace60..ae735dcc5 100644
--- a/misc-utils/uuidparse.1
+++ b/misc-utils/uuidparse.1
@@ -72,7 +72,7 @@ Sami Kerola
 RFC 4122
 .UE
 .SH AVAILABILITY
-The example command is part of the util-linux package and is available from
+The uuidparse command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
 Linux Kernel Archive
 .UE .
diff --git a/sys-utils/irqtop.1 b/sys-utils/irqtop.1
index 4cf941b2a..bd5d641c4 100644
--- a/sys-utils/irqtop.1
+++ b/sys-utils/irqtop.1
@@ -72,7 +72,7 @@ Sami Kerola
 Karel Zak
 .ME
 .SH AVAILABILITY
-The example command is part of the util-linux package and is available from
+The irqtop command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
 Linux Kernel Archive
 .UE .
diff --git a/sys-utils/lsirq.1 b/sys-utils/lsirq.1
index df0133ee5..f19aa1447 100644
--- a/sys-utils/lsirq.1
+++ b/sys-utils/lsirq.1
@@ -56,7 +56,7 @@ Sami Kerola
 Karel Zak
 .ME
 .SH AVAILABILITY
-The example command is part of the util-linux package and is available from
+The lsirq command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
 Linux Kernel Archive
 .UE .
-- 
2.28.0.rc1

