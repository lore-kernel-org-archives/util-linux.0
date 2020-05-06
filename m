Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DCAC28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 10:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5A020663
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588761565;
	bh=Tood1hjzWdG0CtExopLHNgW9G1xkn0R+CFn2jwQpEs0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=P/QTkkkepPGKmskQASbXs1l5Mfx+E7qg3ZP9ZGat2eKSUQ9dVOmaiDxoE9weZt458
	 l40jA5BtVZkKACfBeWBDMxsG5etAa2hZ4D6Q0ZRYE2M2nGc3wUf5Edcp38xgs5J+KI
	 KbS1oIOs+c49YhQut6BMKzf7tDxg3jY7JHiUbsRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgEFKjZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 06:39:25 -0400
Received: from sauhun.de ([88.99.104.3]:44618 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgEFKjY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 6 May 2020 06:39:24 -0400
Received: from localhost (p54B3333E.dip0.t-ipconnect.de [84.179.51.62])
        by pokefinder.org (Postfix) with ESMTPSA id A39122C0885;
        Wed,  6 May 2020 12:39:22 +0200 (CEST)
From:   Wolfram Sang <wsa@kernel.org>
To:     util-linux@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>
Subject: [PATCH] (s)fdisk: avoid unneeded empty lines with '--list'
Date:   Wed,  6 May 2020 12:39:21 +0200
Message-Id: <20200506103921.2689-1-wsa@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On my system, I got two superfluous empty lines because /dev/sr0 didn't
contain a medium. Refactor the code to handle the seperator within
print_device_pt() and print it only when assigning the device worked.
This unifies handling between print_all_devices_pt and (s)fdisk because
the latter did not consider the return code for the seperator while the
former did. Also, it saves some lines of code.

Addresses: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=814184 (first part)
Signed-off-by: Wolfram Sang <wsa@kernel.org>
---

If you like this cleanup, I will do the same for
'print_device_freespace' and friends.

 disk-utils/fdisk-list.c | 14 ++++++++------
 disk-utils/fdisk-list.h |  2 +-
 disk-utils/fdisk.c      |  9 ++-------
 disk-utils/sfdisk.c     | 10 +++-------
 4 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/disk-utils/fdisk-list.c b/disk-utils/fdisk-list.c
index 834c7b4e9..78e17a97f 100644
--- a/disk-utils/fdisk-list.c
+++ b/disk-utils/fdisk-list.c
@@ -360,7 +360,8 @@ char *next_proc_partition(FILE **f)
 	return NULL;
 }
 
-int print_device_pt(struct fdisk_context *cxt, char *device, int warnme, int verify)
+int print_device_pt(struct fdisk_context *cxt, char *device, int warnme,
+		    int verify, int seperator)
 {
 	if (fdisk_assign_device(cxt, device, 1) != 0) {	/* read-only */
 		if (warnme || errno == EACCES)
@@ -368,6 +369,9 @@ int print_device_pt(struct fdisk_context *cxt, char *device, int warnme, int ver
 		return -1;
 	}
 
+	if (seperator)
+		fputs("\n\n", stdout);
+
 	list_disk_geometry(cxt);
 
 	if (fdisk_has_label(cxt)) {
@@ -395,15 +399,13 @@ int print_device_freespace(struct fdisk_context *cxt, char *device, int warnme)
 void print_all_devices_pt(struct fdisk_context *cxt, int verify)
 {
 	FILE *f = NULL;
-	int ct = 0;
+	int sep = 0;
 	char *dev;
 
 	while ((dev = next_proc_partition(&f))) {
-		if (ct)
-			fputs("\n\n", stdout);
-		if (print_device_pt(cxt, dev, 0, verify) == 0)
-			ct++;
+		print_device_pt(cxt, dev, 0, verify, sep);
 		free(dev);
+		sep = 1;
 	}
 }
 
diff --git a/disk-utils/fdisk-list.h b/disk-utils/fdisk-list.h
index 4ed5c256b..47518c498 100644
--- a/disk-utils/fdisk-list.h
+++ b/disk-utils/fdisk-list.h
@@ -7,7 +7,7 @@ extern void list_disk_geometry(struct fdisk_context *cxt);
 extern void list_freespace(struct fdisk_context *cxt);
 
 extern char *next_proc_partition(FILE **f);
-extern int print_device_pt(struct fdisk_context *cxt, char *device, int warnme, int verify);
+extern int print_device_pt(struct fdisk_context *cxt, char *device, int warnme, int verify, int seperator);
 extern int print_device_freespace(struct fdisk_context *cxt, char *device, int warnme);
 
 extern void print_all_devices_pt(struct fdisk_context *cxt, int verify);
diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 8a9b8cf2a..bf5307b62 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -1080,15 +1080,10 @@ int main(int argc, char **argv)
 
 		if (argc > optind) {
 			int k;
-			int ct = 0;
 
-			for (rc = 0, k = optind; k < argc; k++) {
-				if (ct)
-				    fputs("\n\n", stdout);
+			for (rc = 0, k = optind; k < argc; k++)
+				rc += print_device_pt(cxt, argv[k], 1, 0, k != optind);
 
-				rc += print_device_pt(cxt, argv[k], 1, 0);
-				ct++;
-			}
 			if (rc)
 				return EXIT_FAILURE;
 		} else
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 07e8b2341..6299cb49c 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -653,15 +653,11 @@ static int command_list_partitions(struct sfdisk *sf, int argc, char **argv)
 	fdisk_enable_listonly(sf->cxt, 1);
 
 	if (argc) {
-		int i, ct = 0;
+		int i;
 
-		for (i = 0; i < argc; i++) {
-			if (ct)
-				fputs("\n\n", stdout);
-			if (print_device_pt(sf->cxt, argv[i], 1, sf->verify) != 0)
+		for (i = 0; i < argc; i++)
+			if (print_device_pt(sf->cxt, argv[i], 1, sf->verify, i) != 0)
 				fail++;
-			ct++;
-		}
 	} else
 		print_all_devices_pt(sf->cxt, sf->verify);
 
-- 
2.26.2

