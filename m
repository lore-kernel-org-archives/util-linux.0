Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33166 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab1I3KF2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Sep 2011 06:05:28 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2D0458EE65
	for <util-linux@vger.kernel.org>; Fri, 30 Sep 2011 12:05:27 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/2] losetup: print verbose messages if requested
Date: Fri, 30 Sep 2011 12:05:25 +0200
Message-Id: <1317377126-13302-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

verbose can't be > 1

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/lomount.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mount/lomount.c b/mount/lomount.c
index ff99413..441860b 100644
--- a/mount/lomount.c
+++ b/mount/lomount.c
@@ -930,7 +930,7 @@ set_loop(const char *device, const char *file, unsigned long long offset,
 	if (!(*options & SETLOOP_AUTOCLEAR))
 		close (fd);
 
-	if (verbose > 1)
+	if (verbose)
 		printf(_("set_loop(%s,%s,%llu,%llu): success\n"),
 		       device, filename, offset, sizelimit);
 	if (file != filename)
@@ -951,7 +951,7 @@ del_loop (const char *device) {
 		goto error;
 	}
 	close (fd);
-	if (verbose > 1)
+	if (verbose)
 		printf(_("del_loop(%s): success\n"), device);
 	return 0;
 
-- 
1.7.3.4

