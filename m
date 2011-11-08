Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41616 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab1KHWP2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Nov 2011 17:15:28 -0500
Received: by bke11 with SMTP id 11so873318bke.19
        for <util-linux@vger.kernel.org>; Tue, 08 Nov 2011 14:15:27 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH] whereis: remove unused value warning
Date: Tue,  8 Nov 2011 23:14:54 +0100
Message-Id: <1320790495-29290-3-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1320790495-29290-1-git-send-email-cosoleto@gmail.com>
References: <1320790495-29290-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 misc-utils/whereis.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 9f74963..925cc93 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -268,7 +268,7 @@ static void fillpath(void)
 		return;
 	pathcp = xstrdup(path);
 
-	for (tmp = pathcp; ;tmp = NULL, tok) {
+	for (tmp = pathcp; ; tmp = NULL) {
 		tok = strtok_r(tmp, ":", &key);
 		if (!tok)
 			break;
-- 
1.7.3.4

