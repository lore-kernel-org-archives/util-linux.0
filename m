Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:60145 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751066AbbHAIYi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 1 Aug 2015 04:24:38 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 7/7] unshare: remove angular brackets from literal argument in usage text
Date: Sat,  1 Aug 2015 10:23:11 +0200
Message-Id: <1438417391-2269-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1438417391-2269-1-git-send-email-bensberg@justemail.net>
References: <1438417391-2269-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/unshare.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index b01500c..47dda94 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -245,7 +245,7 @@ static void usage(int status)
 	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
 	fputs(_("     --mount-proc[=<dir>]  mount proc filesystem first (implies --mount)\n"), out);
 	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
-	fputs(_("     --propagation <slave|shared|private|unchanged>\n"
+	fputs(_("     --propagation slave|shared|private|unchanged\n"
 	        "                           modify mount propagation in mount namespace\n"), out);
 	fputs(_(" -s, --setgroups allow|deny  control the setgroups syscall in user namespaces\n"), out);
 
-- 
1.7.0.4

