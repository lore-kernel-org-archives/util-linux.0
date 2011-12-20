Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57181 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab1LTNgJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 20 Dec 2011 08:36:09 -0500
Received: by qadc12 with SMTP id c12so2981786qad.19
        for <util-linux@vger.kernel.org>; Tue, 20 Dec 2011 05:36:08 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/3] column: use xalloc libs
Date: Tue, 20 Dec 2011 08:36:02 -0500
Message-Id: <1324388164-2112-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 text-utils/column.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 79d2842..c642680 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -395,7 +395,7 @@ static wchar_t *mbs_to_wcs(const char *s)
 	n = mbstowcs((wchar_t *)0, s, 0);
 	if (n < 0)
 		return NULL;
-	wcs = malloc((n + 1) * sizeof(wchar_t));
+	wcs = xmalloc((n + 1) * sizeof(wchar_t));
 	if (!wcs)
 		return NULL;
 	n = mbstowcs(wcs, s, n + 1);
-- 
1.7.8

