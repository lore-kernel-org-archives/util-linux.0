Return-Path: <SRS0=rKDH=AV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CF8C433E0
	for <util-linux@archiver.kernel.org>; Fri, 10 Jul 2020 01:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9C620772
	for <util-linux@archiver.kernel.org>; Fri, 10 Jul 2020 01:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGJBjM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJBjL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Jul 2020 21:39:11 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F69FC08C5CE
        for <util-linux@vger.kernel.org>; Thu,  9 Jul 2020 18:39:11 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 06A1d9LN002626
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Fri, 10 Jul 2020 01:39:09 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 06A1d9LN002626
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 06A1d9NJ002985
        for <util-linux@vger.kernel.org>; Fri, 10 Jul 2020 01:39:09 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 06A1d9YL002984
        for util-linux@vger.kernel.org; Fri, 10 Jul 2020 01:39:09 GMT
Date:   Fri, 10 Jul 2020 01:39:09 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] Subject: docs: disk-utils: change "allows to <verb>" to
 "allows <verb>ing"
Message-ID: <20200710013909.GA2922@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  The web site "lintian.debian.org" shows some examples of "allows to",
which are changed to "allows one to".

  I chose here to use gerund.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 disk-utils/fdisk.8     | 2 +-
 disk-utils/sfdisk.8    | 6 +++---
 disk-utils/swaplabel.8 | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index f683bcaaa..8780a7419 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -200,7 +200,7 @@ are deprecated.
 
 .SH SCRIPT FILES
 .B fdisk
-allows to read (by 'I' command) sfdisk compatible script files. The script is
+allows reading (by 'I' command) sfdisk compatible script files. The script is
 applied to in-memory partition table, and then it is possible to modify the
 partition table before you write it to the device.
 .PP
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 6c278afb6..38a674853 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -295,7 +295,7 @@ disk label (see the \fBEMPTY DISK LABEL\fR section below).
 .TP
 .BR \-Y , " \-\-label\-nested " \fItype
 Force editing of a nested disk label.  The primary disk label has to exist already.
-This option allows to edit for example a hybrid/protective MBR on devices with GPT.
+This option allows editing for example a hybrid/protective MBR on devices with GPT.
 
 .TP
 .BR \-w , " \-\-wipe "\fIwhen
@@ -469,7 +469,7 @@ loaders and for other operating systems.
 
 .B Named-fields format
 .RS
-This format is more readable, robust, extensible and allows to specify additional
+This format is more readable, robust, extensible and allows specifying additional
 information (e.g., a UUID).  It is recommended to use this format to keep your scripts
 more readable.
 .RS
@@ -480,7 +480,7 @@ more readable.
 The
 .I device
 field is optional.  \fBsfdisk\fR extracts the partition number from the
-device name.  It allows to specify the partitions in random order.
+device name.  It allows specifying the partitions in random order.
 This functionality is mostly used by \fB\-\-dump\fR.
 Don't use it if you are not sure.
 
diff --git a/disk-utils/swaplabel.8 b/disk-utils/swaplabel.8
index b623a5020..c92de00a5 100644
--- a/disk-utils/swaplabel.8
+++ b/disk-utils/swaplabel.8
@@ -35,7 +35,7 @@ These values can also be set during swap creation using
 .BR mkswap (8).
 The
 .B swaplabel
-utility allows to change the label or UUID on an actively used swap device.
+utility allows changing the label or UUID on an actively used swap device.
 .SH OPTIONS
 .TP
 .BR \-h , " \-\-help"
-- 
2.27.0
