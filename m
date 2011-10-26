Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:22430 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751Ab1JZMYY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Oct 2011 08:24:24 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0LTO0010VAFZSUB0@damascus.uab.es> for
 util-linux@vger.kernel.org; Wed, 26 Oct 2011 14:24:00 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0LTO0083JAFZDD30@damascus.uab.es>
 forutil-linux@vger.kernel.org; Wed, 26 Oct 2011 14:23:59 +0200 (CEST)
Date: Wed, 26 Oct 2011 16:26:49 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] docs: update TODO file
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1319639209.3771.14.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 Documentation/TODO |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index 2a4ab22..583a96a 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -1,10 +1,6 @@
 
  Note that items with (!) have high priority.
 
-prlimit
--------
-  - add new command line wrapper for prlimit(2)
-
 dmesg
 -----
 
@@ -96,13 +92,6 @@ libblkd and libmountL
 partx
 -----
 
- - (!) add support loop devices:
-
-	partx -a /path/file.img
-
-	* associate the file with loop device (use lib/loopdev.c)
-	* map partitions by BLKPG_ADD_PARTITION
-
  - support mapping by device-mapper if argv[0] is "kpartx" or --dm option is used.
      
  - (!) add regression tests for partx, addpart and delpart
-- 
1.7.7



