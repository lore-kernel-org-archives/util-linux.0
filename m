Return-Path: <SRS0=2QVQ=PP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC45C43387
	for <util-linux@archiver.kernel.org>; Mon,  7 Jan 2019 19:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C112070B
	for <util-linux@archiver.kernel.org>; Mon,  7 Jan 2019 19:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfAGTmY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:42:24 -0500
Received: from mx.datacom.ind.br ([177.66.5.10]:59358 "EHLO
        mail.datacom.com.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726742AbfAGTmY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 7 Jan 2019 14:42:24 -0500
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2019 14:42:23 EST
Received: from mail.datacom.com.br (localhost [127.0.0.1])
        by mail.datacom.com.br (Postfix) with ESMTPS id 0DADA1BA22DE
        for <util-linux@vger.kernel.org>; Mon,  7 Jan 2019 17:32:45 -0200 (-02)
Received: from localhost (localhost [127.0.0.1])
        by mail.datacom.com.br (Postfix) with ESMTP id F253A1BA22C2
        for <util-linux@vger.kernel.org>; Mon,  7 Jan 2019 17:32:44 -0200 (-02)
Received: from mail.datacom.com.br ([127.0.0.1])
        by localhost (mail.datacom.com.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F8hEbGITqzim for <util-linux@vger.kernel.org>;
        Mon,  7 Jan 2019 17:32:44 -0200 (-02)
Received: from pedeld202344.datacom.net (pedeld202344.datacom.net [10.0.120.87])
        by mail.datacom.com.br (Postfix) with ESMTPSA id C75E01BA22B6
        for <util-linux@vger.kernel.org>; Mon,  7 Jan 2019 17:32:44 -0200 (-02)
From:   Carlos Santos <casantos@datacom.com.br>
To:     util-linux@vger.kernel.org
Subject: [PATCH] utmpdump: fix word swapping in manual page
Date:   Mon,  7 Jan 2019 17:32:34 -0200
Message-Id: <20190107193234.9442-1-casantos@datacom.com.br>
X-Mailer: git-send-email 2.14.5
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From
    The only binary version of the utmp(5) is standardised.
To
    Only the binary version of the utmp(5) is standardised.

Change-Id: I0033f6cf055d569c7dfca5e05e918f735ea72582
Signed-off-by: Carlos Santos <casantos@datacom.com.br>
---
 login-utils/utmpdump.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index 1f458e8d6..9e6b5a3c2 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -59,7 +59,7 @@ But be warned,
 was written for debugging purposes only.
 .SS File formats
 .PP
-The only binary version of the
+Only the binary version of the
 .BR utmp (5)
 is standardised.  Textual dumps may become incompatible in future.
 .PP
-- 
2.14.5

