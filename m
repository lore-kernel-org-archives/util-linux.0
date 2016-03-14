Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:50863 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752813AbcCNJKy (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 05:10:54 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] unshare: replace a special character in the man page with a space
Date: Mon, 14 Mar 2016 10:10:12 +0100
Message-Id: <1457946613-2435-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
References: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reported-by: Andreas Henriksson <andreas@fatal.se>
Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/unshare.1 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 264f139..9507c4e 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -164,7 +164,7 @@ by nsenter. The namespace is destroyed by umount the bind reference.
 .TQ
 .B # touch /root/namespaces/mnt
 .TQ
-.B # unshare --mount=/root/namespaces/mnt
+.B # unshare --mount=/root/namespaces/mnt
 .br
 Establish a persistent mount namespace referenced by the bind mount
 /root/namespaces/mnt. This example provides portable solution, because it makes
-- 
1.7.0.4

