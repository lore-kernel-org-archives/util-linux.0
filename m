Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:44494 "EHLO
	homiemail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753459Ab1HGAKh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Aug 2011 20:10:37 -0400
Subject: [PATCH] libmnt: fix undefined sources
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 06 Aug 2011 20:10:26 -0400
Message-ID: <1312675826.3408.1.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

The path resolving function breaks when handling undefined sources ("none") used by pseudo-filesystems. The assertion is causing the samples/mount program
to abort:

dave@offbook:~/projects/util-linux-good/libmount/samples$ ./mount
/dev/sda3 on / type ext4 (rw,errors=remount-ro,commit=0)
proc on /proc type proc (rw,noexec,nosuid,nodev)
lt-mount: cache.c:464: mnt_resolve_path: Assertion `path' failed.
Aborted

/etc/mtab:

/dev/sda3 / ext4 rw,errors=remount-ro,commit=0 0 0
proc /proc proc rw,noexec,nosuid,nodev 0 0
none /sys sysfs rw,noexec,nosuid,nodev 0 0
fusectl /sys/fs/fuse/connections fusectl rw 0 0
none /sys/kernel/debug debugfs rw 0 0
...

Instead of this assert on NULL we can simply return NULL and let mnt_pretty_path do the work.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 libmount/src/cache.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/libmount/src/cache.c b/libmount/src/cache.c
index 802d072..41aa4fe 100644
--- a/libmount/src/cache.c
+++ b/libmount/src/cache.c
@@ -461,8 +461,6 @@ char *mnt_resolve_path(const char *path, struct libmnt_cache *cache)
 	char *key = NULL;
 	char *value = NULL;
 
-	assert(path);
-
 	/*DBG(CACHE, mnt_debug_h(cache, "resolving path %s", path));*/
 
 	if (!path)
-- 
1.7.4.1



