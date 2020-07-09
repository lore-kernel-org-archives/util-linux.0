Return-Path: <SRS0=l+by=AU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0888CC433E0
	for <util-linux@archiver.kernel.org>; Thu,  9 Jul 2020 23:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E105D20674
	for <util-linux@archiver.kernel.org>; Thu,  9 Jul 2020 23:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGIXu2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgGIXu2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Jul 2020 19:50:28 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E8C08C5CE
        for <util-linux@vger.kernel.org>; Thu,  9 Jul 2020 16:50:27 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 069NoQUb029685
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Thu, 9 Jul 2020 23:50:26 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 069NoQUb029685
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 069NoQ3V029754
        for <util-linux@vger.kernel.org>; Thu, 9 Jul 2020 23:50:26 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 069NoQnh029753
        for util-linux@vger.kernel.org; Thu, 9 Jul 2020 23:50:26 GMT
Date:   Thu, 9 Jul 2020 23:50:26 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] Subject: docs: change from nofill to fill mode
Message-ID: <20200709235026.GA29712@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Change request nofill mode to fill mode.

  Warning from "mandoc -Tlint":

mandoc: ./misc-utils/uuidd.8.in:81:2: STYLE: fill mode already disabled, skipping: nf

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 misc-utils/uuidd.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/uuidd.8.in b/misc-utils/uuidd.8.in
index 3c8e2025b..fda5108b1 100644
--- a/misc-utils/uuidd.8.in
+++ b/misc-utils/uuidd.8.in
@@ -78,7 +78,7 @@ Start up a daemon, print 42 random keys, and then stop the daemon:
 uuidd \-p /tmp/uuidd.pid \-s /tmp/uuidd.socket
 uuidd \-d \-r \-n 42 \-s /tmp/uuidd.socket
 uuidd \-d \-k \-s /tmp/uuidd.socket
-.nf
+.fi
 .RE
 .SH AUTHOR
 The
-- 
2.27.0
