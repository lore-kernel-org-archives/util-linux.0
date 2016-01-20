Return-Path: util-linux-owner@vger.kernel.org
Received: from monitoringp.xen.prgmr.com ([71.19.155.36]:45502 "EHLO
	monitoringp.xen.prgmr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934202AbcATERu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Jan 2016 23:17:50 -0500
From: "Wayne R. Roth" <wayneroth42@gmail.com>
To: util-linux@vger.kernel.org
Cc: "Wayne R. Roth" <wayneroth42@gmail.com>
Subject: [PATCH] mkswap: Add warnings for insecure device permissions/owners Logic modified from sys-utils/swapon.c
Date: Tue, 19 Jan 2016 20:17:39 -0800
Message-Id: <1453263459-19555-1-git-send-email-wayneroth42@gmail.com>
In-Reply-To: <20160119194443.GD14840@vapier.lan>
References: <20160119194443.GD14840@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: "Wayne R. Roth" <wayneroth42@gmail.com>

Signed-off-by: Wayne R. Roth <wayneroth42@gmail.com>
---
 disk-utils/mkswap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index c559e60..0a8dc05 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -344,7 +344,7 @@ static void write_header_to_device(struct mkswap_control *ctl)
 int main(int argc, char **argv)
 {
 	struct mkswap_control ctl = { .fd = -1 };
-	int c;
+	int c, permMask;
 	uint64_t sz;
 	int version = SWAP_VERSION;
 	char *block_count = NULL, *strsz = NULL;
@@ -464,6 +464,15 @@ int main(int argc, char **argv)
 			ctl.devname);
 
 	open_device(&ctl);
+        permMask = S_ISBLK(ctl.devstat.st_mode) ? 07007 : 07077;
+        if ((ctl.devstat.st_mode & permMask) != 0)
+                warnx(_("%s: insecure permissions %04o, %04o suggested."),
+                                ctl.devname, ctl.devstat.st_mode & 07777,
+                                ~permMask & 0666);
+        if (getuid()==0 && S_ISREG(ctl.devstat.st_mode) && ctl.devstat.st_uid != 0)
+                warnx(_("%s: insecure file owner %d, 0 (root) suggested."),
+                                ctl.devname, ctl.devstat.st_uid);
+
 
 	if (ctl.check)
 		check_blocks(&ctl);
-- 
1.8.3.1

