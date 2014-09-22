Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:61876 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754771AbaIVUPx (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:15:53 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/10] textual: use angular brackets around each individual argument
Date: Mon, 22 Sep 2014 22:15:31 +0200
Message-Id: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In usage texts each word that is an argument should be marked
separately with angular brackets.  Also add a translator comment.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/renice.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index 100f6a5..c96e39a 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -66,7 +66,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -n, --priority <num>   specify the nice increment value\n"), out);
 	fputs(_(" -p, --pid <id>         interpret argument as process ID (default)\n"), out);
 	fputs(_(" -g, --pgrp <id>        interpret argument as process group ID\n"), out);
-	fputs(_(" -u, --user <name|id>   interpret argument as username or user ID\n"), out);
+	fputs(_(" -u, --user <name>|<id> interpret argument as username or user ID\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -176,6 +176,8 @@ int main(int argc, char **argv)
 		} else {
 			who = strtol(*argv, &endptr, 10);
 			if (who < 0 || *endptr) {
+				/* TRANSLATORS: The first %s is one of the above
+				 * three ID names. Read: "bad value for %s: %s" */
 				warnx(_("bad %s value: %s"), idtype[which], *argv);
 				errs = 1;
 				continue;
-- 
1.7.0.4

