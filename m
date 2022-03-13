Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D3DC433EF
	for <util-linux@archiver.kernel.org>; Sun, 13 Mar 2022 09:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiCMJpZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Mar 2022 05:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbiCMJpT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2022 05:45:19 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B77B558
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2022 01:44:11 -0800 (PST)
X-KPN-MessageId: 21ca8ddf-a2b2-11ec-944c-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 21ca8ddf-a2b2-11ec-944c-005056994fde;
        Sun, 13 Mar 2022 10:44:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=mime-version:message-id:date:subject:to:from;
        bh=QOWFuQZS4VONwMJL99EgPxikNYsR6V1I6DqUsD3/z3M=;
        b=dbbU7UuKmm2ZQQWZ1ml6TKb/nHSxRxujBsG/y2LJ/pDxhTB6o7bpXS8bQcFDtdyJ6+umfNCED2Wgh
         mDmmuV8wqHCKZa6WD069uNAUyjzC30UnaZuRMXNhxFW5CrbD0KssNyqID2DhKdA2B44nKQSZ8ag0Ir
         KUUd473MGyv9BAh4=
X-KPN-MID: 33|GbPct/G3G/WDhVgHb/Yr2wEgwiG5waeTWcrGbBVPhZfqYexvsgnbulpXFrKZrJo
 OiZReWbrgbd6mmtA9sg+m50xP9Vo8joh1sGcUrbMpt6g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vo2lqu1KbMCzgTdP52mrktC1KOXCr3suQQJnQpsLhSJCUBWMLjVjvaqMlx0wp2o
 q8OjRhsZ4F+t8x8TNcplJcw==
X-Originating-IP: 82.168.50.91
Received: from localhost (82-168-50-91.fixed.kpn.net [82.168.50.91])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id 222ae588-a2b2-11ec-807e-00505699b758;
        Sun, 13 Mar 2022 10:44:10 +0100 (CET)
From:   Benno Schulenberg <bensberg@telfort.nl>
To:     util-linux@vger.kernel.org
Subject: [PATCH 1/2 v2] hardlink: set all locale elements, so that messages will get translated
Date:   Sun, 13 Mar 2022 10:43:56 +0100
Message-Id: <20220313094357.2546-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This setting and binding were lost a year ago, in commit 2180ecc81b.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/hardlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index 932048622..d4bb48386 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -1329,8 +1329,10 @@ int main(int argc, char *argv[])
 	sigaction(SIGINT, &sa, NULL);
 	sigaction(SIGUSR1, &sa, NULL);
 
-	/* Pretty print numeric output */
-	setlocale(LC_NUMERIC, "");
+	/* Localize messages, number formatting, and anything else. */
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
 
 	if (atexit(to_be_called_atexit) != 0)
 		err(EXIT_FAILURE, _("cannot register exit handler"));
-- 
2.34.1

