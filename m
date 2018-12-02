Return-Path: <SRS0=/Na4=OL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF4C04EB8
	for <util-linux@archiver.kernel.org>; Sun,  2 Dec 2018 18:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D616B20834
	for <util-linux@archiver.kernel.org>; Sun,  2 Dec 2018 18:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D616B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbeLBSXu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 2 Dec 2018 13:23:50 -0500
Received: from mout.gmx.net ([212.227.17.22]:38049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbeLBSXt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 2 Dec 2018 13:23:49 -0500
Received: from adsiz.fritz.box ([95.90.40.253]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlqNY-1h2rDu36AK-00ZS3l for
 <util-linux@vger.kernel.org>; Sun, 02 Dec 2018 19:23:46 +0100
From:   Ruediger Meier <sweet_f_a@gmx.de>
To:     util-linux@vger.kernel.org
Subject: [PATCH] include/c: re-add type checking in container_of()
Date:   Sun,  2 Dec 2018 19:23:45 +0100
Message-Id: <20181202182345.3508-1-sweet_f_a@gmx.de>
X-Mailer: git-send-email 2.13.7
X-Provags-ID: V03:K1:pof9wWZ2+Jgz9L5/823DcXfyx9gZc6PXm1sief8TKUqKO8HCKWQ
 wknFzYiaf3AjTKuAlK0OhkbHq33oR+mjx9ES10QljFaEsey7VO2EyS50Cs2AM8hSmoResSp
 gKiME/R6B2OMk7cSEzWa1zC3YVwc+4XzcWTXL5bB5D3jZhH7cHMzR55Vz3CkeN1UAxfxYOy
 5FNutULcdqOorSDpYdw8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dhl9iqAATS4=:TTXTD+hy0pXkK7ndEPQmGZ
 cX+4Bg/kjvSN3VlmjoP6B94tsVBDyhOZD/X2sMxM3w7yO7zDGZyq1USCI9GVE9CxHgHVo+sjA
 47IJmOHVPdMBkO0Kc+VAztYZyaMfqLubdiR2Ld0nBOhHtCl4GdUkNJDwaLsixAMzQudBCAbwx
 rsZzxH1CbTkBNfQ7tWSsvhYvDPeUigF+rY6ylkC6MMtP6PaIxWQroNmFytIks1QuyO8dVV1cs
 3HlrEPw2mZZ7QVyPNgbkfPomsX8iuDMjjajp3RSEwhEG99DCv2JU0l9Ij1twQPIY3oDkluilV
 o9KDm5gjnwAwJcERfRQE34fYi5AIMTSZDOrI2BFdT8k+JgS7fb3Q1/tbZ2snHKz3OVXDXpNx2
 7WXJLXCeigO+NFw+mKco3qEhiOt4ZTNtFFcaCK1UlbtmhvWs1wRG2kebnKos8fLMb6CA8fLhF
 PufmeR451Yr8cqa0mJ8qt53X47E6tDYeYWaers0xneY0qgUXVrD5z+8qxrzANePHFQBtAiS+m
 5nPeM9f/HrfxP3mipm2I5gjzaHcCACh8jDRNW3+fHINfC3+g0FsQ3tJoLf5VZs9UNg2dMb/os
 ABxuizzfeHlAGWNoiWPxqNdv9r8e3L3sUMPefgNFtjqCy0hHPIyBjORRQzKPynylrBz8cU0Zy
 mEGCH4AtvC2l9IRn+IDMgECFbwkBNYmoT0ZP2DeYp/e+WBJz77BO05BHoBdGKzdikpRN/rbT5
 LpTx65fgFaubAJ/wmaPB0oJzqQl4TsMKyGMps95d599cKtbC4CHfOtQJvouD8/q3RW8owTYGl
 jjcP8qQYryKJAx+wFOxS9FFym5i+q9b/ZOrh+X6D7EcCC+WC/df0tRPbThpKDS5X0sf8bav93
 6L2JsWSzpZ9LqXg6+XDayluQlFlzJDKoEotAsHVbBo4m6J7QOpk+vUshbqjOFU
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This reverts parts of commit eb06d5d4, which seems to be based on
Linux kernel commit c7acec71. Unlike the original kernel patch we did
not add that even stronger type checking by using macro BUILD_BUG_ON_MSG.
So basically we removed a useful warning when compiling such
broken code:

      struct st {
            int a;
            char b;
      };
      struct st t = { .a = 1, .b = 2 };
      struct st *x = container_of(&t.a, struct st, b);
      printf("%p %p\n", (void *)&t, (void *)x);

Moreover we also introduced a new compiler warning for intel/icc:
   "arithmetic on pointer to void or function type"

Let's just revert the update of container_of() because adding a
kernel-like BUILD_BUG_ON_MSG would be too much noise and also
problematic (see kernel commit c03567a8). Also note that the original
problem addressed by the kernel commit seems to be only reproducible
with gcc 4.9, not with any later gcc nor clang,icc. Moreover, currently
we have no such use-case in the UL sources anyways.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/c.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/c.h b/include/c.h
index 8b2a2d19a..f1e329819 100644
--- a/include/c.h
+++ b/include/c.h
@@ -147,8 +147,8 @@
  */
 #ifndef container_of
 #define container_of(ptr, type, member) __extension__ ({	\
-	void *__mptr = (void *)(ptr);				\
-	((type *)(__mptr - offsetof(type, member))); })
+	const __typeof__( ((type *)0)->member ) *__mptr = (ptr); \
+	(type *)( (char *)__mptr - offsetof(type,member) );})
 #endif
 
 #ifndef HAVE_PROGRAM_INVOCATION_SHORT_NAME
-- 
2.13.7

