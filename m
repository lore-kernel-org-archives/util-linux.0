Return-Path: <SRS0=0wgv=CT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9828DC433E2
	for <util-linux@archiver.kernel.org>; Thu, 10 Sep 2020 20:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5116020829
	for <util-linux@archiver.kernel.org>; Thu, 10 Sep 2020 20:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgIJUxJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgIJUwg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Sep 2020 16:52:36 -0400
X-Greylist: delayed 2169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Sep 2020 13:52:23 PDT
Received: from faun.innocircle.com (faun.innocircle.com [IPv6:2a01:4f8:121:5248::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3D0C061573
        for <util-linux@vger.kernel.org>; Thu, 10 Sep 2020 13:52:23 -0700 (PDT)
Received: from local by faun.innocircle.com (envelope-from <gero@70t.de>)
        id 1kGSzJ-000669-93
        for util-linux@vger.kernel.org; Thu, 10 Sep 2020 22:16:09 +0200
Date:   Thu, 10 Sep 2020 22:16:09 +0200
From:   Gero Treuner <gero@70t.de>
To:     util-linux@vger.kernel.org
Subject: fallocate: fix for --dig-holes at end of files
Message-ID: <X1qJiQa2MHpJ55IG@innocircle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
User-Agent: Mutt/1.14.5+79 (e53ae9e) ()
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I discovered that making a file sparse with "fallocate -d filename"
fails on the last block of a file, because - usually being partial - the
system call only zeroes that part instead of deallocating the block. See
man fallocate(2) - section "Deallocating file space".

The expected call is punching the whole block beyond eof, which doesn't
change the file length because of flag FALLOC_FL_KEEP_SIZE.


The following commands illustrate this (all on Debian buster with a real
existing file).


Behaviour with fallocate from system: file gets fragmented

user:~/dev/util-linux$ cp /usr/lib/locale/C.UTF-8/LC_CTYPE .
user:~/dev/util-linux$ /usr/sbin/filefrag -e ./LC_CTYPE
Filesystem type is: 9123683e
File size of ./LC_CTYPE is 200752 (50 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected:
flags:
   0:        0..      49:   22403653..  22403702:     50:
last,eof
./LC_CTYPE: 1 extent found
user:~/dev/util-linux$ fallocate -v -d ./LC_CTYPE 
./LC_CTYPE: 48 B (48 bytes) converted to sparse holes.
user:~/dev/util-linux$ /usr/sbin/filefrag -e ./LC_CTYPE
Filesystem type is: 9123683e
File size of ./LC_CTYPE is 200752 (50 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected:
flags:
   0:        0..      48:   22403653..  22403701:     49:            
   1:       49..      49:   22385666..  22385666:      1:   22403702:
last,eof
./LC_CTYPE: 2 extents found
user:~/dev/util-linux$ du -s ./LC_CTYPE 
200     ./LC_CTYPE


Behaviour with fixed fallocate: file becomes sparse

user:~/dev/util-linux$ cp /usr/lib/locale/C.UTF-8/LC_CTYPE .
user:~/dev/util-linux$ ./fallocate -v -d ./LC_CTYPE 
./LC_CTYPE: 48 B (48 bytes) converted to sparse holes.
user:~/dev/util-linux$ /usr/sbin/filefrag -e ./LC_CTYPE
Filesystem type is: 9123683e
File size of ./LC_CTYPE is 200752 (50 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected:
flags:
   0:        0..      48:   22346286..  22346334:     49:
last
./LC_CTYPE: 1 extent found
user:~/dev/util-linux$ du -s ./LC_CTYPE 
196     ./LC_CTYPE


Please consider the attached patch. I also tested with other files
containing real holes (instead of a notch) that function is preserved.


Kind regards,
   Gero

--m51xatjYGsM+13rf
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fallocate-fix-dig-holes-at-end-of-files.patch"

From 7b3e0a3921ca7c84fa3913b2bb916be938dfe04a Mon Sep 17 00:00:00 2001
From: Gero Treuner <gero@70t.de>
Date: Thu, 10 Sep 2020 21:43:03 +0200
Subject: [PATCH] fallocate: fix --dig-holes at end of files

---
 sys-utils/fallocate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 014b94624..ba97092fc 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -264,8 +264,11 @@ static void dig_holes(int fd, off_t file_off, off_t len)
 			off += rsz;
 		}
 		if (hole_sz) {
+			off_t alloc_sz = hole_sz;
+			if (off >= end)
+				alloc_sz += st.st_blksize;		/* meet block boundary */
 			xfallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE,
-					hole_start, hole_sz);
+					hole_start, alloc_sz);
 			ct += hole_sz;
 		}
 		file_off = off;
-- 
2.20.1


--m51xatjYGsM+13rf--
