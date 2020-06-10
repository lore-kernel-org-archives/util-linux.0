Return-Path: <SRS0=qkB4=7X=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADF2C433DF
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 21:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7B820656
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 21:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFJVtN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgFJVtN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2020 17:49:13 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311F5C03E96B
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 14:49:13 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05ALnBl2010302
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 21:49:11 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 05ALnBl2010302
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05ALnAlg018336
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 21:49:11 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05ALnAZA018335
        for util-linux@vger.kernel.org; Wed, 10 Jun 2020 21:49:10 GMT
Date:   Wed, 10 Jun 2020 21:49:10 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] doc: disk-utils/*: Fix some warnings from "mandoc -T lint"
Message-ID: <20200610214910.GA18305@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

mandoc: ./disk-utils/fsck.minix.8:123:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./disk-utils/isosize.8:8:2: WARNING: skipping paragraph macro: PP after SH

mandoc: ./disk-utils/sfdisk.8:262:4: STYLE: unterminated quoted argument

mandoc: ./disk-utils/swaplabel.8:57:2: WARNING: skipping paragraph macro: PP empty

####

  No change in the output from "nroff" or "groff".

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>

####
---
 disk-utils/fsck.minix.8 | 1 -
 disk-utils/isosize.8    | 1 -
 disk-utils/sfdisk.8     | 2 +-
 disk-utils/swaplabel.8  | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/disk-utils/fsck.minix.8 b/disk-utils/fsck.minix.8
index 0c26ed3ee..ca050897c 100644
--- a/disk-utils/fsck.minix.8
+++ b/disk-utils/fsck.minix.8
@@ -120,7 +120,6 @@ Operational error
 Usage or syntax error
 .PD
 .RE
-.PP
 .SH AUTHORS
 .MT torvalds@\:cs.\:helsinki.\:fi
 Linus Torvalds
diff --git a/disk-utils/isosize.8 b/disk-utils/isosize.8
index 6e072f943..8d5899396 100644
--- a/disk-utils/isosize.8
+++ b/disk-utils/isosize.8
@@ -5,7 +5,6 @@ isosize \- output the length of an iso9660 filesystem
 .B isosize
 .RI [options] " iso9660_image_file"
 .SH DESCRIPTION
-.PP
 This command outputs the length of an iso9660 filesystem that
 is contained in the specified file.  This file may be a normal file or
 a block device (e.g.\& /dev/hdd or /dev/sr0).  In the absence of
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index e3b479cbf..6c278afb6 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -259,7 +259,7 @@ and the last command reorders partitions to match disk order
 .sp
 .B "echo '+100M,' | sfdisk \-\-move-data /dev/sdc \-N 1"
 .br
-.B "echo '2048,' | sfdisk /dev/sdc \-\-append
+.B "echo '2048,' | sfdisk /dev/sdc \-\-append"
 .br
 .B sfdisk /dev/sdc \-\-reorder
 .sp
diff --git a/disk-utils/swaplabel.8 b/disk-utils/swaplabel.8
index f22b8f443..b623a5020 100644
--- a/disk-utils/swaplabel.8
+++ b/disk-utils/swaplabel.8
@@ -54,7 +54,6 @@ Specify a new \fIUUID\fR for the device.
 The \fI UUID\fR
 must be in the standard 8-4-4-4-12 character format, such as is output by
 .BR uuidgen (1).
-.PP
 .SH ENVIRONMENT
 .IP LIBBLKID_DEBUG=all
 enables libblkid debug output.
-- 
2.26.2
