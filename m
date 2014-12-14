Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57876 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbaLNRo4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:44:56 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so6896738wid.11
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:44:55 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/16] lslogins: tell why command failed
Date: Sun, 14 Dec 2014 17:43:59 +0000
Message-Id: <1418579052-29386-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Printing usage() without hint what is wrong does not help an user.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 85fd7c8..7fe6599 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1437,7 +1437,7 @@ int main(int argc, char *argv[])
 		logins = argv[optind];
 		outmode = OUT_PRETTY;
 	} else if (argc != optind)
-		usage(stderr);
+		errx(EXIT_FAILURE, _("Only one user may be specified. Use -l for multiple users."));
 
 	scols_init_debug(0);
 
-- 
2.1.3

