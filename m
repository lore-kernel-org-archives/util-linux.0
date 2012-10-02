Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:56187 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab2JBUP1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Oct 2012 16:15:27 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1465466wib.1
        for <util-linux@vger.kernel.org>; Tue, 02 Oct 2012 13:15:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] swapon: check numeric user inputs
Date: Tue,  2 Oct 2012 21:15:16 +0100
Message-Id: <1349208918-11946-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index c9cabc1..3fe6592 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -730,7 +730,8 @@ int main(int argc, char *argv[])
 			usage(stdout);
 			break;
 		case 'p':		/* priority */
-			priority = atoi(optarg);
+			priority = strtos16_or_err(optarg,
+					   _("failed to parse argument"));
 			break;
 		case 'L':
 			add_label(optarg);
-- 
1.7.12.2

