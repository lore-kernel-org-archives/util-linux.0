Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:38292
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760544AbcBYKdb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 25 Feb 2016 05:33:31 -0500
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] libfdisk: Fix order of C/H/S numbers output
Date: Thu, 25 Feb 2016 11:26:53 +0100
Message-Id: <1456396013-15757-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

While the header says C/H/S the actual numbers where printed as
C/S/H.

Addresses: http://bugs.debian.org/815847
Reported-by: "groups, freeman" <freeman_groups@reason.dyndns.org>
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 libfdisk/src/dos.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index 2f3a37b..b199225 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -1903,15 +1903,15 @@ static int dos_get_partition(struct fdisk_context *cxt, size_t n,
 	/* start C/H/S */
 	if (asprintf(&pa->start_chs, "%d/%d/%d",
 				cylinder(p->bs, p->bc),
-				sector(p->bs),
-				p->bh) < 0)
+				p->bh,
+				sector(p->bs)) < 0)
 		return -ENOMEM;
 
 	/* end C/H/S */
 	if (asprintf(&pa->end_chs, "%d/%d/%d",
 				cylinder(p->es, p->ec),
-				sector(p->es),
-				p->eh) < 0)
+				p->eh,
+				sector(p->es)) < 0)
 		return -ENOMEM;
 
 	return 0;
-- 
2.7.0

