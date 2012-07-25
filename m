Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54496 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab2GYTQE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:04 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1068839wgb.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/19] fdisk: add noreturn function attribute
Date: Wed, 25 Jul 2012 21:15:35 +0200
Message-Id: <1343243745-1172-18-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/fdisk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 32b6de9..7fca5b6 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -159,7 +159,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-void fatal(struct fdisk_context *cxt, enum failure why)
+void __attribute__((__noreturn__))
+fatal(struct fdisk_context *cxt, enum failure why)
 {
 	close(cxt->dev_fd);
 	switch (why) {
-- 
1.7.11.3

