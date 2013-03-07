Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:38272 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab3CGX1d (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Mar 2013 18:27:33 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so1880432wgb.20
        for <util-linux@vger.kernel.org>; Thu, 07 Mar 2013 15:27:31 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/7] kill: add long options
Date: Thu,  7 Mar 2013 23:27:18 +0000
Message-Id: <1362698844-21292-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
References: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 10730a3..e43f23a 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -193,11 +193,11 @@ int main (int argc, char *argv[])
 	    printf(UTIL_LINUX_VERSION);
 	    return 0;
 	}
-	if (! strcmp (arg, "-a")) {
+	if (! strcmp (arg, "-a") || ! strcmp (arg, "--all")) {
 	    check_all++;
 	    continue;
 	}
-	if (! strcmp (arg, "-l")) {
+	if (! strcmp (arg, "-l") || ! strcmp (arg, "--list")) {
 	    if (argc < 2) {
 		printsignals (stdout);
 		return 0;
@@ -214,13 +214,13 @@ int main (int argc, char *argv[])
 	    printsig (numsig);
 	    return 0;
 	}
-	if (! strcmp (arg, "-p")) {
+	if (! strcmp (arg, "-p") || ! strcmp (arg, "--pid")) {
 	    do_pid++;
 	    if (do_kill)
 		return usage (1);
 	    continue;
 	}
-	if (! strcmp (arg, "-s")) {
+	if (! strcmp (arg, "-s") || ! strcmp (arg, "--signal")) {
 	    if (argc < 2) {
 		return usage (1);
 	    }
@@ -235,7 +235,7 @@ int main (int argc, char *argv[])
 	    }
 	    continue;
 	}
-	if (! strcmp (arg, "-q")) {
+	if (! strcmp (arg, "-q") || ! strcmp (arg, "--queue")) {
 	    if (argc < 2)
 		return usage (1);
 	    argc--, argv++;
-- 
1.8.1.5

