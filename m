Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51101 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756369AbaFWRlt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Jun 2014 13:41:49 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5NHfnID031955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 23 Jun 2014 13:41:49 -0400
Received: from dhcp-189-44.bos.redhat.com ([10.18.25.138])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5NHfnS2012205
	for <util-linux@vger.kernel.org>; Mon, 23 Jun 2014 13:41:49 -0400
From: David Shea <dshea@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Correct the return values in squashfs probe
Date: Mon, 23 Jun 2014 13:41:48 -0400
Message-Id: <1403545308-18371-1-git-send-email-dshea@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Returning -1 can cause squashfs v3 detection to make v4 detection fail.
---
 libblkid/src/superblocks/squashfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libblkid/src/superblocks/squashfs.c b/libblkid/src/superblocks/squashfs.c
index a35d60f..c8f9641 100644
--- a/libblkid/src/superblocks/squashfs.c
+++ b/libblkid/src/superblocks/squashfs.c
@@ -41,7 +41,7 @@ static int probe_squashfs(blkid_probe pr, const struct blkid_idmag *mag)
 	major = le16_to_cpu(sq->s_major);
 	minor = le16_to_cpu(sq->s_minor);
 	if (major < 4)
-		return -1;
+		return 1;
 
 	blkid_probe_sprintf_version(pr, "%u.%u", major, minor);
 
@@ -56,7 +56,7 @@ static int probe_squashfs3(blkid_probe pr, const struct blkid_idmag *mag)
 
 	sq = blkid_probe_get_sb(pr, mag, struct sqsh_super_block);
 	if (!sq)
-		return -1;
+		return 1;
 
 	if (strcmp(mag->magic, "sqsh") == 0) {
 		major = be16_to_cpu(sq->s_major);
@@ -67,7 +67,7 @@ static int probe_squashfs3(blkid_probe pr, const struct blkid_idmag *mag)
 	}
 
 	if (major > 3)
-		return -1;
+		return 1;
 
 	blkid_probe_sprintf_version(pr, "%u.%u", major, minor);
 
-- 
2.0.0

