Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:39125 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755996Ab2DXIVF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 04:21:05 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 786629141C
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 10:21:04 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 8/9] sfdisk: fix compiler warning [-Wunused-result]
Date: Tue, 24 Apr 2012 10:21:00 +0200
Message-Id: <1335255661-10611-8-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
References: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sfdisk.c: In function ‘do_fdisk’:
sfdisk.c:3212:11: error: ignoring return value of ‘fgets’, declared with attribute warn_unused_result [-Werror=unused-result]

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 95e5828..0d36c3f 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -3208,7 +3208,7 @@ do_fdisk(char *dev) {
 		printf(_("Are you satisfied with this? [ynq] "));
 	    else
 		printf(_("Do you want to write this to disk? [ynq] "));
-	    fgets(answer, sizeof(answer), stdin);
+	    ignore_result( fgets(answer, sizeof(answer), stdin) );
 	    if (answer[0] == 'q' || answer[0] == 'Q') {
 		errx(EXIT_FAILURE, _("Quitting - nothing changed"));
 	    } else if (rpmatch(answer) == 1) {
-- 
1.7.7

