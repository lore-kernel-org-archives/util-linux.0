Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f43.google.com ([209.85.192.43]:58876 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbaGaIxH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 31 Jul 2014 04:53:07 -0400
Received: by mail-qg0-f43.google.com with SMTP id a108so3308435qge.2
        for <util-linux@vger.kernel.org>; Thu, 31 Jul 2014 01:53:05 -0700 (PDT)
From: Sergei Antonov <saproj@gmail.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Sergei Antonov <saproj@gmail.com>
Subject: [PATCH] libfdisk: (gpt) add Microsoft Storage Spaces GUID
Date: Thu, 31 Jul 2014 12:51:37 +0200
Message-Id: <1406803897-3913-1-git-send-email-saproj@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Storage Spaces is Microsoft's latest logical volume management.
It has been around since Windows 8.

Cc: Karel Zak <kzak@redhat.com>
Signed-off-by: Sergei Antonov <saproj@gmail.com>
---
 libfdisk/src/gpt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 1b5ffb4..d5acf95 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -162,6 +162,7 @@ static struct fdisk_parttype gpt_parttypes[] =
 	DEF_GUID("AF9B60A0-1431-4F62-BC68-3311714A69AD", N_("Microsoft LDM data")),
 	DEF_GUID("DE94BBA4-06D1-4D40-A16A-BFD50179D6AC", N_("Windows recovery environment")),
 	DEF_GUID("37AFFC90-EF7D-4E96-91C3-2D7AE055B174", N_("IBM General Parallel Fs")),
+	DEF_GUID("E75CAF8F-F680-4CEE-AFA3-B001E56EFC2D", N_("Microsoft Storage Spaces")),
 
 	/* HP-UX */
 	DEF_GUID("75894C1E-3AEB-11D3-B7C1-7B03A0000000", N_("HP-UX data")),
-- 
1.9.0

