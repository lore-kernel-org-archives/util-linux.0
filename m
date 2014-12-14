Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:52931 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbaLNRp0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:26 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so6801140wiv.17
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:25 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/16] chfn: fix usage() regression
Date: Sun, 14 Dec 2014 17:44:07 +0000
Message-Id: <1418579052-29386-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit db433bf737a5fd4e1c7cca5e3603934743eebd1c changed -u for --help to
-h, that is not true.  The -h is short hand for --home-phone.  And the
--version is accompanied with -v not -V.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 4746927..9833591 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -77,8 +77,8 @@ static void __attribute__((__noreturn__)) usage(FILE *fp)
 	fputs(_(" -p, --office-phone <phone>   office phone number\n"), fp);
 	fputs(_(" -h, --home-phone <phone>     home phone number\n"), fp);
 	fputs(USAGE_SEPARATOR, fp);
-	fputs(USAGE_HELP, fp);
-	fputs(USAGE_VERSION, fp);
+	fputs(_(" -u, --help     display this help and exit\n"), fp);
+	fputs(_(" -v, --version  output version information and exit\n"), fp);
 	fprintf(fp, USAGE_MAN_TAIL("chfn(1)"));
 	exit(fp == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
2.1.3

