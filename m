Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:52321 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929Ab1JMNKt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 13 Oct 2011 09:10:49 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 116488D40D
	for <util-linux@vger.kernel.org>; Thu, 13 Oct 2011 15:10:49 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] fstrim: fix section number in referral to manpage
Date: Thu, 13 Oct 2011 15:10:45 +0200
Message-Id: <1318511445-12863-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reported-by: Roeland Jansen <roeland@linux-it.nl>
Addresses: https://bugzilla.novell.com/show_bug.cgi?id=723877

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 sys-utils/fstrim.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index 29c6561..cc50674 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -63,7 +63,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		" -m, --minimum <num> minimum extent length to discard\n"
 		" -v, --verbose       print number of discarded bytes\n"), out);
 
-	fputs(_("\nFor more information see fstrim(1).\n"), out);
+	fputs(_("\nFor more information see fstrim(8).\n"), out);
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.7.3.4

