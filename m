Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50769 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657Ab2EMLop (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 May 2012 07:44:45 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 403ABA39FF
	for <util-linux@vger.kernel.org>; Sun, 13 May 2012 13:44:45 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 3/3] mkswap: improve diagnostics message if the device is mounted
Date: Sun, 13 May 2012 13:44:32 +0200
Message-Id: <1336909472-12277-3-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336909472-12277-1-git-send-email-petr.uzel@suse.cz>
References: <1336909472-12277-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Currently, attempt to create swap on mounted partition results
with "/dev/sdXy: Device or resource busy" message being printed.
Change this to explicitly telling the user that the device is mounted.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 disk-utils/mkswap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index dec34e1..43129a7 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -582,6 +582,11 @@ main(int argc, char **argv) {
 			PAGES * pagesize / 1024);
 	}
 
+	if (is_mounted(device_name))
+		errx(EXIT_FAILURE, _("error: "
+			"%s is mounted; will not make swapspace."),
+			device_name);
+
 	if (stat(device_name, &statbuf) < 0) {
 		perror(device_name);
 		exit(EXIT_FAILURE);
@@ -598,10 +603,6 @@ main(int argc, char **argv) {
 
 	if (!S_ISBLK(statbuf.st_mode))
 		check=0;
-	else if (is_mounted(device_name))
-		errx(EXIT_FAILURE, _("error: "
-			"%s is mounted; will not make swapspace."),
-			device_name);
 	else if (blkdev_is_misaligned(DEV))
 		warnx(_("warning: %s is misaligned"), device_name);
 
-- 
1.7.7

