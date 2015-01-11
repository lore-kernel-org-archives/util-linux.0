Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:51372 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751695AbbAKV2W (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 16:28:22 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] partx: simplify a --verbose progress message
Date: Sun, 11 Jan 2015 22:27:57 +0100
Message-Id: <1421011678-5890-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1421011678-5890-1-git-send-email-bensberg@justemail.net>
References: <1421011678-5890-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reported-by: Antonio Ceballos <aceballos@gmail.com>
Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/partx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 00c2631..d1dc6f1 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -309,7 +309,7 @@ static int del_parts(int fd, const char *device, dev_t devno,
 			continue;
 		} else if (errno == ENXIO) {
 			if (verbose)
-				printf(_("%s: partition #%d already doesn't exist\n"), device, i);
+				printf(_("%s: partition #%d doesn't exist\n"), device, i);
 			continue;
 		}
 		rc = -1;
-- 
1.7.0.4

