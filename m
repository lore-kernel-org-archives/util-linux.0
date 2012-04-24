Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:39124 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755992Ab2DXIVF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 04:21:05 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 18F9B912E4
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 10:21:04 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 7/9] fsck.minix.c: fix compiler warnings [-Wunused-result]
Date: Tue, 24 Apr 2012 10:20:59 +0200
Message-Id: <1335255661-10611-7-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
References: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

fsck.minix.c: In function ‘ask’:
fsck.minix.c:263:7: error: ignoring return value of ‘fgets’, declared with attribute warn_unused_result [-Werror=unused-result]

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 disk-utils/fsck.minix.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 8b3ce62..139ab7a 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -260,7 +260,7 @@ ask(const char *string, int def) {
 	 * translated.  */
 	printf(def ? _("%s (y/n)? ") : _("%s (n/y)? "), string);
 	fflush(stdout);
-	fgets(input, YESNO_LENGTH, stdin);
+	ignore_result( fgets(input, YESNO_LENGTH, stdin) );
 	resp = rpmatch(input);
 	switch (resp) {
 	case -1:
-- 
1.7.7

