Return-Path: util-linux-owner@vger.kernel.org
Received: from g4t3425.houston.hp.com ([15.201.208.53]:27204 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914AbaGVXpF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 19:45:05 -0400
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 01/13] sfdisk: remove bogus argc check
Date: Tue, 22 Jul 2014 16:44:45 -0700
Message-Id: <1406072697-20912-2-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It makes no sense to check for argc < 1, remove this logic.

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/sfdisk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index a54763d..9fc71b4 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -2552,8 +2552,6 @@ main(int argc, char **argv) {
     textdomain(PACKAGE);
     atexit(close_stdout);
 
-    if (argc < 1)
-	errx(EXIT_FAILURE, _("no command?"));
     if (!strcmp(program_invocation_short_name, "activate"))
 	activate = 1;		/* equivalent to `sfdisk -A' */
 
-- 
1.8.1.4

