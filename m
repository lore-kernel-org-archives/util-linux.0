Return-Path: <SRS0=Sgv+=WW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51F3C3A59F
	for <util-linux@archiver.kernel.org>; Mon, 26 Aug 2019 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5FE2184D
	for <util-linux@archiver.kernel.org>; Mon, 26 Aug 2019 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfHZTPF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:15:05 -0400
Received: from outpost.hi.is ([130.208.165.166]:40214 "EHLO outpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbfHZTPF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Aug 2019 15:15:05 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 15:15:03 EDT
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by outpost.hi.is (8.14.7/8.14.7) with ESMTP id x7QJ54D0017263
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Mon, 26 Aug 2019 19:05:04 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 outpost.hi.is x7QJ54D0017263
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id x7QJ51lO027767
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Mon, 26 Aug 2019 19:05:02 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is x7QJ51lO027767
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id x7QJ51Jt003751
        for <util-linux@vger.kernel.org>; Mon, 26 Aug 2019 19:05:01 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id x7QJ51gX003746
        for util-linux@vger.kernel.org; Mon, 26 Aug 2019 19:05:01 GMT
Date:   Mon, 26 Aug 2019 19:05:01 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] sys-utils/manuals: Make the number of the paired macros
 ".RS" and ".RE" equal
Message-ID: <20190826190501.GA3707@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Adjust the number of the macros ".RS" and ".RE" to be equal.

  There is no change in the formatted output.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 sys-utils/chcpu.8 | 1 -
 sys-utils/fstab.5 | 1 +
 sys-utils/mount.8 | 2 --
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sys-utils/chcpu.8 b/sys-utils/chcpu.8
index 2fb71115f..832881d84 100644
--- a/sys-utils/chcpu.8
+++ b/sys-utils/chcpu.8
@@ -89,7 +89,6 @@ failure
 .TP
 .B 64
 partial success
-.RE
 .SH AUTHOR
 .MT heiko.carstens@de.ibm.com
 Heiko Carstens
diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index a9e9f8c54..ff27866ab 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -214,6 +214,7 @@ of 2.  Filesystems within a drive will be checked sequentially, but
 filesystems on different drives will be checked at the same time to utilize
 parallelism available in the hardware.
 Defaults to zero (don't fsck) if not present.
+.RE
 
 .SH NOTES
 The proper way to read records from
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 56d3520be..ce6ba77fa 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -441,7 +441,6 @@ without interaction with the bind semantic. This
 behavior does not affect situations when "remount,bind" is specified in the
 .I /etc/fstab
 file.
-.RE
 
 .SS The move operation
 Move a
@@ -2439,7 +2438,6 @@ mount failure
 .TP
 .B 64
 some mount succeeded
-.RE
 
 The command \fBmount \-a\fR returns 0 (all succeeded), 32 (all failed), or 64 (some
 failed, some succeeded).
-- 
2.23.0.rc1
