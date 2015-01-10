Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:51360 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752709AbbAJNlm (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 10 Jan 2015 08:41:42 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] setarch: differentiate between "unrecognized" and "cannot set"
Date: Sat, 10 Jan 2015 14:41:32 +0100
Message-Id: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When the provided string does not match any architecture that
setarch knows about, the response stays "Unrecognized architecture",
but when trying to set the specified architecture does not have any
effect, then respond with "Kernel cannot set architecture to...".

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/setarch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 8e52179..a09625c 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -247,7 +247,7 @@ static int set_arch(const char *pers, unsigned long options, int list)
 			&& strcmp(un.machine, "i586")
 			&& strcmp(un.machine, "i686")
 			&& strcmp(un.machine, "athlon")))
-			errx(EXIT_FAILURE, _("%s: Unrecognized architecture"), pers);
+			errx(EXIT_FAILURE, _("Kernel cannot set architecture to %s"), pers);
 	}
 	return 0;
 }
-- 
1.7.0.4

