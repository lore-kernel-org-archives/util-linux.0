Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB84C00140
	for <util-linux@archiver.kernel.org>; Wed, 24 Aug 2022 12:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiHXMOx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Aug 2022 08:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbiHXMOw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 24 Aug 2022 08:14:52 -0400
X-Greylist: delayed 1308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 05:14:47 PDT
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38973C46
        for <util-linux@vger.kernel.org>; Wed, 24 Aug 2022 05:14:46 -0700 (PDT)
Received: from chris by delta.arachsys.com with local (Exim 4.80)
        (envelope-from <chris@arachsys.com>)
        id 1oQowJ-00033E-9z
        for util-linux@vger.kernel.org; Wed, 24 Aug 2022 12:52:55 +0100
Date:   Wed, 24 Aug 2022 12:52:55 +0100
From:   Chris Webb <chris@arachsys.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] unshare: Don't waste an ID when -r is used with --map-auto
Message-ID: <5e2a06cda7e0449aa2a1ce63ee069f942546e73b.1661341169.git.chris@arachsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When --map-root-user or --map-current-user are used with --map-auto, one of
the IDs from the first range in /etc/subuid and /etc/subgid is wasted and
left unmapped:

  $ cat /etc/subuid
  1000:65536:100
  $ unshare --map-auto cat /proc/self/uid_map
           0      65536        100
  $ unshare --map-root-user --map-auto cat /proc/self/uid_map
           0       1000          1
           1      65536         99

In the second unshare, only 99 of the 100 UIDs available from /etc/subuid
are actually mapped, whereas in the first unshare, all 100 delegated UIDs
are correctly mapped.

Distinguish auto mappings from manually-specified ones so they can be
handled correctly, while still ensuring explicit --map-users/groups that
overlap with the single mapping are correctly reduced in length because
of the hole that's punched:

  $ unshare --map-auto cat /proc/self/uid_map
           0      65536        100
  $ unshare  --map-root-user --map-auto cat /proc/self/uid_map
           0       1000          1
           1      65536        100

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 sys-utils/unshare.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index a379e8aed..f5fe046a8 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -437,7 +437,7 @@ static struct map_range *read_subid_range(char *filename, uid_t uid)
 	struct map_range *map;
 
 	map = xmalloc(sizeof(*map));
-	map->inner = 0;
+	map->inner = -1;
 
 	pw = xgetpwuid(uid, &pwbuf);
 	if (!pw)
@@ -538,10 +538,10 @@ map_ids(const char *idmapper, int ppid, unsigned int outer, unsigned int inner,
 	push_ul(ppid);
 	if ((int)inner == -1) {
 		/*
-		 * If we don't have a "single" mapping, then we can just use
-		 * map directly
+		 * If we don't have a "single" mapping, then we can just use map
+		 * directly, starting inner IDs from zero for an auto mapping
 		 */
-		push_ul(map->inner);
+		push_ul(map->inner + 1 ? map->inner : 0);
 		push_ul(map->outer);
 		push_ul(map->count);
 		push_str(NULL);
@@ -550,9 +550,14 @@ map_ids(const char *idmapper, int ppid, unsigned int outer, unsigned int inner,
 		errexec(idmapper);
 	}
 
-	/* If the mappings overlap, remove an ID from map */
-	if ((outer >= map->outer && outer <= map->outer + map->count) ||
-	    (inner >= map->inner && inner <= map->inner + map->count))
+	/*
+	 * Start inner IDs from zero for an auto mapping; otherwise, if the two
+	 * fixed mappings overlap, remove an ID from map
+	 */
+	if (map->inner + 1 == 0)
+		map->inner = 0;
+	else if ((outer >= map->outer && outer <= map->outer + map->count) ||
+		 (inner >= map->inner && inner <= map->inner + map->count))
 		map->count--;
 
 	/* Determine where the splits between lo, mid, and hi will be */
