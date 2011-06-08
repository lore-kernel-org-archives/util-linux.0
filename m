Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37449 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab1FHWxr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Jun 2011 18:53:47 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so837342iyb.19
        for <util-linux@vger.kernel.org>; Wed, 08 Jun 2011 15:53:46 -0700 (PDT)
From: Josiah Worcester <josiahw@gmail.com>
To: util-linux@vger.kernel.org
Cc: Josiah Worcester <josiahw@gmail.com>
Subject: [PATCH 5/6] test_sysinfo: Use CHAR_BIT*sizeof(void*) instead of __WORDSIZE.
Date: Wed,  8 Jun 2011 16:52:47 -0600
Message-Id: <1307573568-23643-6-git-send-email-josiahw@gmail.com>
In-Reply-To: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
References: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Josiah Worcester <josiahw@gmail.com>
---
 tests/helpers/test_sysinfo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tests/helpers/test_sysinfo.c b/tests/helpers/test_sysinfo.c
index cb7b66b..a8d80d8 100644
--- a/tests/helpers/test_sysinfo.c
+++ b/tests/helpers/test_sysinfo.c
@@ -28,7 +28,7 @@ typedef struct {
 int
 hlp_wordsize(void)
 {
-	printf("%d\n", __WORDSIZE);
+	printf("%d\n", CHAR_BIT*sizeof(void*));
 	return 0;
 }
 
-- 
1.7.5.3

