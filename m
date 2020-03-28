Return-Path: <SRS0=sRCm=5N=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027DEC2D0ED
	for <util-linux@archiver.kernel.org>; Sat, 28 Mar 2020 22:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34CB2073E
	for <util-linux@archiver.kernel.org>; Sat, 28 Mar 2020 22:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgC1WkW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:40:22 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:44722 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgC1WkW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 28 Mar 2020 18:40:22 -0400
Received: from localhost.localdomain (i19-les04-th2-31-36-16-7.sfr.lns.abo.bbox.fr [31.36.16.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 198DD5648B4;
        Sat, 28 Mar 2020 23:33:54 +0100 (CET)
From:   Aurelien LAJOIE <orel@melix.net>
To:     util-linux@vger.kernel.org
Cc:     Aurelien LAJOIE <orel@melix.net>
Subject: [PATCH 1/3] cal: use a const char*
Date:   Sat, 28 Mar 2020 23:33:39 +0100
Message-Id: <20200328223341.11463-1-orel@melix.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Mar 28 23:33:54 2020 +0100 (CET))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

A put string function should not modify the char*

Signed-off-by: Aurelien LAJOIE <orel@melix.net>
---
 misc-utils/cal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 6f192ccea..728600377 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -108,7 +108,7 @@ static int setup_terminal(char *term
 	return 0;
 }
 
-static void my_putstring(char *s)
+static void my_putstring(const char *s)
 {
 #if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW)
 	if (has_term)
-- 
2.20.1

