Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50766 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199Ab2EMLom (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 May 2012 07:44:42 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Russell Coker <russell@coker.com.au>
Subject: [PATCH 2/3] mkswap: allow creating swap on /dev/hd[ab]
Date: Sun, 13 May 2012 13:44:31 +0200
Message-Id: <1336909472-12277-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336909472-12277-1-git-send-email-petr.uzel@suse.cz>
References: <1336909472-12277-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Currently, mkswap does not allow swap to be created on /dev/hda and
/dev/hdb. There is no reason why /dev/hda and /dev/hdb should be treated
differently.

Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=491021
Cc: Russell Coker <russell@coker.com.au>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 disk-utils/mkswap.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index c7dedd7..dec34e1 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -596,13 +596,8 @@ main(int argc, char **argv) {
 		exit(EXIT_FAILURE);
 	}
 
-	/* Want a block device. Probably not /dev/hda or /dev/hdb. */
 	if (!S_ISBLK(statbuf.st_mode))
 		check=0;
-	else if (statbuf.st_rdev == 0x0300 || statbuf.st_rdev == 0x0340)
-		errx(EXIT_FAILURE, _("error: "
-			"will not try to make swapdevice on '%s'"),
-			device_name);
 	else if (is_mounted(device_name))
 		errx(EXIT_FAILURE, _("error: "
 			"%s is mounted; will not make swapspace."),
-- 
1.7.7

