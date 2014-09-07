Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61794 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbaIGMni (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:38 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so1362180wib.15
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/17] mountpoint: simplify if statement
Date: Sun,  7 Sep 2014 13:42:59 +0100
Message-Id: <1410093785-17537-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Returning straight after print_devno() makes the code to be more obvious
and removes need for long else statement.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/mountpoint.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index 3392cdd..3155dd4 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -132,7 +132,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 int main(int argc, char **argv)
 {
-	int c, rc = 0;
+	int c;
 	struct mountpoint_control ctl = { 0 };
 
 	static const struct option longopts[] = {
@@ -186,18 +186,15 @@ int main(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 	if (ctl.dev_devno)
-		rc = print_devno(&ctl);
-	else {
-		if (dir_to_device(&ctl)) {
-			if (!ctl.quiet)
-				printf(_("%s is not a mountpoint\n"), ctl.devname);
-			return EXIT_FAILURE;
-		}
-		if (ctl.fs_devno)
-			printf("%u:%u\n", major(ctl.dev), minor(ctl.dev));
-		else if (!ctl.quiet)
-			printf(_("%s is a mountpoint\n"), ctl.devname);
+		return print_devno(&ctl) ? EXIT_FAILURE : EXIT_SUCCESS;
+	if (dir_to_device(&ctl)) {
+		if (!ctl.quiet)
+			printf(_("%s is not a mountpoint\n"), ctl.devname);
+		return EXIT_FAILURE;
 	}
-
-	return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+	if (ctl.fs_devno)
+		printf("%u:%u\n", major(ctl.dev), minor(ctl.dev));
+	else if (!ctl.quiet)
+		printf(_("%s is a mountpoint\n"), ctl.devname);
+	return EXIT_SUCCESS;
 }
-- 
2.1.0

