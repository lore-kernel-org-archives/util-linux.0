Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38021 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab2GYTQH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:07 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so1133220wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 17/19] vipw: add noreturn function attribute
Date: Wed, 25 Jul 2012 21:15:38 +0200
Message-Id: <1343243745-1172-21-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/vipw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 3377112..ed3f43b 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -236,7 +236,8 @@ static void pw_edit(int notsetuid)
 	free(editor);
 }
 
-void pw_error(char *name, int err, int eval)
+void __attribute__((__noreturn__))
+pw_error(char *name, int err, int eval)
 {
 	if (err) {
 		if (name)
-- 
1.7.11.3

