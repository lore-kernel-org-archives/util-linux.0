Return-Path: <SRS0=X3tB=OG=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60610C43441
	for <util-linux@archiver.kernel.org>; Tue, 27 Nov 2018 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F412086B
	for <util-linux@archiver.kernel.org>; Tue, 27 Nov 2018 16:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F412086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=squeezehead.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbeK1Day (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:30:54 -0500
Received: from bellows.squeezehead.com ([173.228.98.227]:34370 "EHLO
        bellows.squeezehead.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbeK1Day (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 27 Nov 2018 22:30:54 -0500
X-Greylist: delayed 1060 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 22:30:54 EST
Received: from localhost (c-73-92-49-5.hsd1.ca.comcast.net [73.92.49.5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by bellows.squeezehead.com (Postfix) with ESMTP id DD20410C24;
        Tue, 27 Nov 2018 08:14:50 -0800 (PST)
Date:   Tue, 27 Nov 2018 08:14:49 -0800
From:   Noel Cragg <noel@squeezehead.com>
To:     util-linux@vger.kernel.org
Subject: patch: page size warning message
Message-ID: <20181127161449.azz7fwn4elhh6wao@localhost>
Reply-To: noel@squeezehead.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mvc57bwwfb5arkdf"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--mvc57bwwfb5arkdf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I ran into this while experimenting with alternate page sizes:

  # mkswap -f --label swap -p 2048 swapfile 65536
  mkswap: Using user-specified page size 0, instead of the system value 4096
  mkswap: swapfile: warning: wiping old swap signature.
  Setting up swapspace version 1, size = 64 MiB (67106816 bytes)
  LABEL=swap, UUID=d0521a3a-8594-4d4b-a79b-5259aeac8d45

Note "user-specified page size 0" in the above output.  I've attached
a trival patch to fix that warning message.

--mvc57bwwfb5arkdf
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="pagesize-warning.diff"

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index cbb99dccb..28a139d45 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -82,7 +82,7 @@ static void init_signature_page(struct mkswap_control *ctl)
 		if (ctl->user_pagesize != kernel_pagesize)
 			warnx(_("Using user-specified page size %d, "
 				"instead of the system value %d"),
-				ctl->pagesize, kernel_pagesize);
+				ctl->user_pagesize, kernel_pagesize);
 		ctl->pagesize = ctl->user_pagesize;
 	} else
 		ctl->pagesize = kernel_pagesize;

--mvc57bwwfb5arkdf--
