Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:55572 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753658AbaIVUQG (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:16:06 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/10] textual: grammarize an error message
Date: Mon, 22 Sep 2014 22:15:36 +0200
Message-Id: <1411416940-3249-6-git-send-email-bensberg@justemail.net>
In-Reply-To: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/dmesg.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index f95609f..71e6632 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1395,8 +1395,8 @@ int main(int argc, char *argv[])
 		if (ctl.raw
 		    && ctl.method != DMESG_METHOD_KMSG
 		    && (ctl.fltr_lev || ctl.fltr_fac))
-			    errx(EXIT_FAILURE, _("--raw could be used together with --level or "
-				 "--facility only when read messages from /dev/kmsg"));
+			    errx(EXIT_FAILURE, _("--raw can be used together with --level or "
+				 "--facility only when reading messages from /dev/kmsg"));
 		if (ctl.pager)
 			setup_pager();
 		n = read_buffer(&ctl, &buf);
-- 
1.7.0.4

