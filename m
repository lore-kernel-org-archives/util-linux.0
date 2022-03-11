Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61125C43217
	for <util-linux@archiver.kernel.org>; Fri, 11 Mar 2022 16:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350912AbiCKQ3I (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350329AbiCKQ0r (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 11 Mar 2022 11:26:47 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 08:25:14 PST
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C2D1D304F
        for <util-linux@vger.kernel.org>; Fri, 11 Mar 2022 08:25:14 -0800 (PST)
X-KPN-MessageId: a903fae4-a157-11ec-a7c6-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id a903fae4-a157-11ec-a7c6-005056992ed3;
        Fri, 11 Mar 2022 17:24:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=mime-version:message-id:date:subject:to:from;
        bh=JlwKrsy+cvH0II4oIprRwhQCjMrXpURDNkTp9a3KxaI=;
        b=tZKmat1ugofd5S5iP/yWiTOyIh9pXNB0Wj/5l/Cz7lBYmXq6pBGLZeFCbfikSplQ4Nht034D0bs1i
         WcFySKU/XAR+qKK3ZfrxAY+kA3czElYUVybFvCuUdUuun3aCbwZkqkLVWv6T+WqmPVH9vH4kAFWF9J
         Ly/lGTD3dpkxEdiw=
X-KPN-MID: 33|u1pqRL9TdAAgfPkFObpzW6NBeIES11Qy9ahn787Top5THmgcsa7ucJ6s64JbT5c
 bnnYsuraJrIYr9TpTeMI4quIAU2WOtCrza/A67pxxhnM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nL259X1Hsnkb/n+3iSazkgyTD7/Gmt98/VouD7ukbfDRfg5vGUhI1wOgVj5PAqx
 5SI+zJKy5s+oZZDqtQy2zDw==
X-Originating-IP: 82.168.50.91
Received: from localhost (82-168-50-91.fixed.kpn.net [82.168.50.91])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id ae5c41db-a157-11ec-b2a4-005056998788;
        Fri, 11 Mar 2022 17:24:10 +0100 (CET)
From:   Benno Schulenberg <bensberg@telfort.nl>
To:     util-linux@vger.kernel.org
Subject: [PATCH 1/2] hardlink: set all locale elements, so that messages will get translated
Date:   Fri, 11 Mar 2022 17:23:37 +0100
Message-Id: <20220311162338.4375-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This setting and binding were lost a year ago, in commit 2180ecc81b.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/hardlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index 932048622..49515c10b 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -1329,8 +1329,9 @@ int main(int argc, char *argv[])
 	sigaction(SIGINT, &sa, NULL);
 	sigaction(SIGUSR1, &sa, NULL);
 
-	/* Pretty print numeric output */
-	setlocale(LC_NUMERIC, "");
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
 
 	if (atexit(to_be_called_atexit) != 0)
 		err(EXIT_FAILURE, _("cannot register exit handler"));
-- 
2.34.1

