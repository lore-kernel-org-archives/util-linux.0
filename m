Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:61702 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753658AbaIVUQB (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:16:01 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/10] textual: add a comma for clarity, plus some other tweaks
Date: Mon, 22 Sep 2014 22:15:34 +0200
Message-Id: <1411416940-3249-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 libfdisk/src/context.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index 4931145..4031f0b 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -363,10 +363,10 @@ static int warn_wipe(struct fdisk_context *cxt)
 		if (blkid_probe_lookup_value(pr, "TYPE", &name, 0) == 0 ||
 		    blkid_probe_lookup_value(pr, "PTTYPE", &name, 0) == 0) {
 			fdisk_warnx(cxt, _(
-				"%s: device contains a valid '%s' signature, it's "
-				"strongly recommended to wipe the device by command wipefs(8) "
-				"if this setup is unexpected to avoid "
-				"possible collisions."), cxt->dev_path, name);
+				"%s: device contains a valid '%s' signature; it is "
+				"strongly recommended to wipe the device with "
+				"wipefs(8) if this is unexpected, in order to "
+				"avoid possible collisions"), cxt->dev_path, name);
 			rc = 1;
 		}
 	}
-- 
1.7.0.4

