Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:64486 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965736AbcCPI4U (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 04:56:20 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/8] fdisk, cfdisk, sfdisk: improve the grammar of three messages
Date: Wed, 16 Mar 2016 09:55:49 +0100
Message-Id: <1458118555-4691-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
References: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    2 +-
 disk-utils/fdisk.c  |    4 ++--
 disk-utils/sfdisk.c |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 010a196..3908e31 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -2436,7 +2436,7 @@ static int ui_run(struct cfdisk *cf)
 	DBG(UI, ul_debug("start cols=%zu, lines=%zu", ui_cols, ui_lines));
 
 	if (fdisk_get_collision(cf->cxt)) {
-		ui_warnx(_("Device already contains %s signature, it will be removed by write command."),
+		ui_warnx(_("Device already contains a %s signature; it will be removed by a write command."),
 				fdisk_get_collision(cf->cxt));
 		fdisk_enable_wipe(cf->cxt, 1);
 		ui_hint(_("Press a key to continue."));
diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 3f8769d..c941e5b 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -974,7 +974,7 @@ int main(int argc, char **argv)
 		if (fdisk_get_collision(cxt)) {
 			int dowipe = wipemode == WIPEMODE_ALWAYS ? 1 : 0;
 
-			fdisk_warnx(cxt, _("%s: device already contains %s signature."),
+			fdisk_warnx(cxt, _("Device %s already contains a %s signature."),
 				argv[optind], fdisk_get_collision(cxt));
 
 			if (isatty(STDIN_FILENO) && wipemode == WIPEMODE_AUTO)
@@ -983,7 +983,7 @@ int main(int argc, char **argv)
 			fdisk_enable_wipe(cxt, dowipe);
 			if (dowipe)
 				fdisk_warnx(cxt, _(
-					"The signature will be removed by write command."));
+					"The signature will be removed by a write command."));
 			else
 				fdisk_warnx(cxt, _(
 					"It is strongly recommended to wipe the device with "
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 1d5050b..80654fc 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1537,7 +1537,7 @@ static int command_fdisk(struct sfdisk *sf, int argc, char **argv)
 	if (fdisk_get_collision(sf->cxt)) {
 		int dowipe = sf->wipemode == WIPEMODE_ALWAYS ? 1 : 0;
 
-		fdisk_warnx(sf->cxt, _("%s: device already contains %s signature."),
+		fdisk_warnx(sf->cxt, _("Device %s already contains a %s signature."),
 			devname, fdisk_get_collision(sf->cxt));
 
 		if (sf->interactive && sf->wipemode == WIPEMODE_AUTO)
@@ -1546,7 +1546,7 @@ static int command_fdisk(struct sfdisk *sf, int argc, char **argv)
 		fdisk_enable_wipe(sf->cxt, dowipe);
 		if (dowipe)
 			fdisk_warnx(sf->cxt, _(
-				"The signature will be removed by write command."));
+				"The signature will be removed by a write command."));
 		else
 			fdisk_warnx(sf->cxt, _(
 				"It is strongly recommended to wipe the device with "
-- 
1.7.0.4

