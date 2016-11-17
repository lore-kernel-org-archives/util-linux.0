Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:55132 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754318AbcKQCKG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 16 Nov 2016 21:10:06 -0500
Received: from tenfore.ga-group.nl ([77.12.158.253]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgvEY-1cbbXZ3zaY-00oDbw for
 <util-linux@vger.kernel.org>; Thu, 17 Nov 2016 03:10:04 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] build-sys: fix "remove the g in git describe"
Date: Thu, 17 Nov 2016 03:10:02 +0100
Message-Id: <1479348602-31744-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de>
References: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

The "g" was not always removed and "-rc*" follow-ups were handled
incorrectly.

So now after last commits we have these versions:

 git describe            -> blkid -V
 --------------------------------------------------------------
 v2.29-rc4               -> 2.29-rc4          (libblkid 2.29.0)
 v2.29-rc4-3-g4c8928d    -> 2.29-rc4-3-4c89   (libblkid 2.29.0)

 v2.29                   -> 2.29              (libblkid 2.29.0)
 v2.29-78-g4c8928d       -> 2.29.78-4c89      (libblkid 2.29.78)

 v2.29.1                 -> 2.29.1            (libblkid 2.29.1)
 v2.29.1-4-g4c8928d      -> 2.29.1.4-4c89     (libblkid 2.29.1)

 v2.29.1-rc2             -> 2.29.1-rc2        (libblkid 2.29.1)
 v2.29.1-rc2-3-g4c8928d  -> 2.29.1-rc2-3-4c89 (libblkid 2.29.1)

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tools/git-version-gen | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/git-version-gen b/tools/git-version-gen
index 3e431ef..e7249f9 100755
--- a/tools/git-version-gen
+++ b/tools/git-version-gen
@@ -112,16 +112,16 @@ elif test "`git log -1 --pretty=format:x . 2>&1`" = x \
        esac
 then
 
+    # Remove the "g" in git describe's output string, to save a byte.
+    v=${v/-g/-}
+
     case $v in
-        *-rc[0-9])
-	    # Remove the "g" in git describe's output string, to save a byte.
-            v=`echo "$v" | sed 's/\(.*\)-g/\1-/'`;     
-	    ;;
+        *-rc*)
+            ;;
         *)
-	    # Change the first '-' to a '.', so version-comparing tools work properly.
-	    # Remove the "g" in git describe's output string, to save a byte.
-	    v=`echo "$v" | sed 's/-/./;s/\(.*\)-g/\1-/'`;
-	    ;;
+            # Change the first '-' to a '.', so version-comparing tools work properly.
+            v=`echo "$v" | sed 's/-/./'`;
+            ;;
     esac
     v_from_git=1
 else
-- 
1.8.5.6

