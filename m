Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f179.google.com ([209.85.215.179]:41326 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGT4Q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:16 -0400
Received: by mail-ea0-f179.google.com with SMTP id b15so2496334eae.24
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 26/34] login: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:41 +0100
Message-Id: <1373226889-3451-27-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/login.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 89df489..fbfc199 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1290,7 +1290,6 @@ int main(int argc, char **argv)
 			fprintf(stderr, _("Usage: login [-p] [-h <host>] [-H] [[-f] <username>]\n"));
 			exit(EXIT_FAILURE);
 		}
-	argc -= optind;
 	argv += optind;
 
 	if (*argv) {
-- 
1.8.3.2

