Return-Path: <SRS0=ljW/=AC=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699C1C433E0
	for <util-linux@archiver.kernel.org>; Sun, 21 Jun 2020 22:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B81C252ED
	for <util-linux@archiver.kernel.org>; Sun, 21 Jun 2020 22:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgFUW6a (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 21 Jun 2020 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFUW6a (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 21 Jun 2020 18:58:30 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E345DC061794
        for <util-linux@vger.kernel.org>; Sun, 21 Jun 2020 15:58:29 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05LMwRGU031959
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Sun, 21 Jun 2020 22:58:28 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 05LMwRGU031959
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05LMwR6e003646
        for <util-linux@vger.kernel.org>; Sun, 21 Jun 2020 22:58:27 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05LMwRLe003645
        for util-linux@vger.kernel.org; Sun, 21 Jun 2020 22:58:27 GMT
Date:   Sun, 21 Jun 2020 22:58:27 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] sys-utils: mount.8: split a long line into two
Message-ID: <20200621225827.GA3587@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Split two long lines, adding '\e' at the end of the first part,
as otherwise the last part of them disappears at the right margin in
the printed output (pdf).

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 sys-utils/mount.8 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index e7215226c..4315fd6e5 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2604,8 +2604,10 @@ For example commands:
 .B mksquashfs /etc /tmp/etc.squashfs
 .B dd if=/dev/zero of=/tmp/etc.hash bs=1M count=10
 .B veritysetup format /tmp/etc.squashfs /tmp/etc.hash
-.B openssl smime \-sign \-in <hash> \-nocerts \-inkey private.key \-signer private.crt \-noattr \-binary \-outform der \-out /tmp/etc.p7
-.B mount \-o verity.hashdevice=/tmp/etc.hash,verity.roothash=<hash>,verity.roothashsig=/tmp/etc.p7 /tmp/etc.squashfs /mnt
+.B openssl smime \-sign \-in <hash> \-nocerts \-inkey private.key \e
+.B \-signer private.crt \-noattr \-binary \-outform der \-out /tmp/etc.p7
+.B mount \-o verity.hashdevice=/tmp/etc.hash,verity.roothash=<hash>,\e
+.B verity.roothashsig=/tmp/etc.p7 /tmp/etc.squashfs /mnt
 .fi
 .RE
 .sp
-- 
2.27.0
