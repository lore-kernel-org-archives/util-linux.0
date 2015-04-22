Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52447 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbbDVRnT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 22 Apr 2015 13:43:19 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: blkdiscard progress breakes test
Date: Wed, 22 Apr 2015 19:43:06 +0200
Cc: Federico Simoncelli <fsimonce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201504221943.06644.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Commit c472a7e3 introduced progress messages. This randomly
breaks the test-suite like this:


   blkdiscard: offsets                        ... FAILED (blkdiscard/offsets)
....
--- /home/abuild/rpmbuild/BUILD/util-linux-2.26.git233.01aa/tests/expected/blkdiscard/offsets   2014-10-28 06:53:35.483698330 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.26.git233.01aa/tests/output/blkdiscard/offsets     2015-04-22 15:41:45.748155291 +0000
@@ -21,7 +21,8 @@
 blkdiscard: offset 1 is not aligned to sector size 512
 blkdiscard: offset 1 is not aligned to sector size 512
 blkdiscard: offset 511 is not aligned to sector size 512
-Discarded 1536 bytes from the offset 512
+Discarded 1024 bytes from the offset 512
+Discarded 512 bytes from the offset 1536
 Discarded 1024 bytes from the offset 1024
 testing misaligned steps full device
 blkdiscard: length 1 is not aligned to sector size 512


It's because we ignore timeval's tv_usec here:
  if (last.tv_sec < now.tv_sec) {
      print_stats(path, stats);

We could make it better if we also compare tv_usec but IMO it would be fine
to print the stats only one time at the end. Maybe
 -v   prints stats one time only
 -vv  report progress


cu,
Rudi
