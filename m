Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63175 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab1KHWP0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Nov 2011 17:15:26 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so873205bke.19
        for <util-linux@vger.kernel.org>; Tue, 08 Nov 2011 14:15:26 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH] libblkid: silence a format string warning
Date: Tue,  8 Nov 2011 23:14:53 +0100
Message-Id: <1320790495-29290-2-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1320790495-29290-1-git-send-email-cosoleto@gmail.com>
References: <1320790495-29290-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix the following clang warning:

 exfat.c:130:41: warning: conversion specifies type 'unsigned short' but
 the argument has type 'uint8_t' (aka 'unsigned char') [-Wformat]
         blkid_probe_sprintf_version(pr, "%hu.%hu",
                                              ~~^
                                              %c

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 libblkid/src/superblocks/exfat.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libblkid/src/superblocks/exfat.c b/libblkid/src/superblocks/exfat.c
index bada3a8..215c671 100644
--- a/libblkid/src/superblocks/exfat.c
+++ b/libblkid/src/superblocks/exfat.c
@@ -127,7 +127,7 @@ static int probe_exfat(blkid_probe pr, const struct blkid_idmag *mag)
 			sb->volume_serial[3], sb->volume_serial[2],
 			sb->volume_serial[1], sb->volume_serial[0]);
 
-	blkid_probe_sprintf_version(pr, "%hu.%hu",
+	blkid_probe_sprintf_version(pr, "%u.%u",
 			sb->version.major, sb->version.minor);
 
 	return 0;
-- 
1.7.3.4

