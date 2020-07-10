Return-Path: <SRS0=rKDH=AV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5335CC433E0
	for <util-linux@archiver.kernel.org>; Fri, 10 Jul 2020 01:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389F920708
	for <util-linux@archiver.kernel.org>; Fri, 10 Jul 2020 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGJBxn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgGJBxn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Jul 2020 21:53:43 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C8C08C5CE
        for <util-linux@vger.kernel.org>; Thu,  9 Jul 2020 18:53:43 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 06A1rfEq003538
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Fri, 10 Jul 2020 01:53:41 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 06A1rfEq003538
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 06A1rfYL003617
        for <util-linux@vger.kernel.org>; Fri, 10 Jul 2020 01:53:41 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 06A1rfZm003616
        for util-linux@vger.kernel.org; Fri, 10 Jul 2020 01:53:41 GMT
Date:   Fri, 10 Jul 2020 01:53:41 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] docs: misc-utils: change "allows to <verb>" to "allows
 <verb>ing"
Message-ID: <20200710015341.GA3608@rhi.hi.is>
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
 misc-utils/findmnt.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 128793451..e411c3010 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -170,7 +170,7 @@ The standard columns always use the new version of the information from the
 mountinfo file, except the umount action which is based on the original
 information cached by
 .BR findmnt (8).
-The poll mode allows to use extra columns:
+The poll mode allows using extra columns:
 .RS
 .TP
 .B ACTION
-- 
2.27.0
