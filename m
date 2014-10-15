Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:47197 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbaJOVT5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Oct 2014 17:19:57 -0400
Received: by mail-wi0-f177.google.com with SMTP id fb4so3067480wid.16
        for <util-linux@vger.kernel.org>; Wed, 15 Oct 2014 14:19:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/4] sfdisk: fix compiler warnings about uninitialized variables
Date: Wed, 15 Oct 2014 22:19:28 +0100
Message-Id: <1413407968-2289-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1413407968-2289-1-git-send-email-kerolasa@iki.fi>
References: <1413407968-2289-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

warning: 'str' may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/sfdisk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index ad0e17e..49369bd 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -756,7 +756,7 @@ static int command_partuuid(struct sfdisk *sf, int argc, char **argv)
 
 	/* print partition uuid */
 	if (!uuid) {
-		const char *str;
+		const char *str = NULL;
 
 		if (fdisk_get_partition(sf->cxt, partno - 1, &pa) == 0)
 			str = fdisk_partition_get_uuid(pa);
@@ -811,7 +811,7 @@ static int command_partlabel(struct sfdisk *sf, int argc, char **argv)
 
 	/* print partition name */
 	if (!name) {
-		const char *str;
+		const char *str = NULL;
 
 		if (fdisk_get_partition(sf->cxt, partno - 1, &pa) == 0)
 			str = fdisk_partition_get_name(pa);
@@ -867,7 +867,7 @@ static int command_partattrs(struct sfdisk *sf, int argc, char **argv)
 
 	/* print partition name */
 	if (!attrs) {
-		const char *str;
+		const char *str = NULL;
 
 		if (fdisk_get_partition(sf->cxt, partno - 1, &pa) == 0)
 			str = fdisk_partition_get_attrs(pa);
-- 
2.1.2

