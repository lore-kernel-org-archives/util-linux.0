Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f194.google.com ([209.85.223.194]:34561 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbbGNUKT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2015 16:10:19 -0400
Received: by ietj16 with SMTP id j16so1440174iet.1
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2015 13:10:18 -0700 (PDT)
Received: from brickies-eth0.mosers.us (d149-67-16-30.nap.wideopenwest.com. [67.149.30.16])
        by smtp.gmail.com with ESMTPSA id w4sm1678097igl.22.2015.07.14.13.10.17
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 13:10:18 -0700 (PDT)
Date: Tue, 14 Jul 2015 16:10:17 -0400 (EDT)
From: Scott Moser <smoser@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] libfdisk: add GPT GUIDs for PReP
Message-ID: <alpine.DEB.2.02.1507141603130.21273@brickies>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Power Firmware (OFW) scans chosen devices for PReP partition IDs.

Signed-off-by: Scott Moser <smoser@ubuntu.com>

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 60d4b5a..0a02cf3 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -242,6 +242,9 @@ static struct fdisk_parttype gpt_parttypes[] =
 	DEF_GUID("0394Ef8B-237C-11E1-B4B3-E89A8F7FC3A7", N_("MidnightBSD UFS")),
 	DEF_GUID("85D5E45D-237C-11E1-B4B3-E89A8F7FC3A7", N_("MidnightBSD ZFS")),
 	DEF_GUID("85D5E45C-237C-11E1-B4B3-E89A8F7FC3A7", N_("MidnightBSD Vinum")),
+
+	/* PowerPC reference platform boot partition */
+	DEF_GUID("9E1A2D38-C612-4316-AA26-8B49521E5A8B", N_("PowerPC PReP boot")),
 };

 /* gpt_entry macros */
