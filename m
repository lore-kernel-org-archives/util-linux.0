Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36641 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab2GYTQF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:05 -0400
Received: by wgbdr13 with SMTP id dr13so1069033wgb.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/19] libblkid: add noreturn function attribute
Date: Wed, 25 Jul 2012 21:15:36 +0200
Message-Id: <1343243745-1172-19-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/dev.c | 2 +-
 libblkid/src/tag.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/dev.c b/libblkid/src/dev.c
index 791a6c1..58ee6f8 100644
--- a/libblkid/src/dev.c
+++ b/libblkid/src/dev.c
@@ -206,7 +206,7 @@ extern char *optarg;
 extern int optind;
 #endif
 
-void usage(char *prog)
+void __attribute__((__noreturn__)) usage(char *prog)
 {
 	fprintf(stderr, "Usage: %s [-f blkid_file] [-m debug_mask]\n", prog);
 	fprintf(stderr, "\tList all devices and exit\n");
diff --git a/libblkid/src/tag.c b/libblkid/src/tag.c
index 0dbe1ff..be4ef35 100644
--- a/libblkid/src/tag.c
+++ b/libblkid/src/tag.c
@@ -390,7 +390,7 @@ extern char *optarg;
 extern int optind;
 #endif
 
-void usage(char *prog)
+void __attribute__((__noreturn__)) usage(char *prog)
 {
 	fprintf(stderr, "Usage: %s [-f blkid_file] [-m debug_mask] device "
 		"[type value]\n",
-- 
1.7.11.3

