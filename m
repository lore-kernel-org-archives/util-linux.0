Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53348 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754238AbcKQCKG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 16 Nov 2016 21:10:06 -0500
Received: from tenfore.ga-group.nl ([77.12.158.253]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIPhr-1c4BTY31o7-0049QT for
 <util-linux@vger.kernel.org>; Thu, 17 Nov 2016 03:10:03 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/5] build-sys: remove old git fallback from git-version-gen
Date: Thu, 17 Nov 2016 03:10:01 +0100
Message-Id: <1479348602-31744-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de>
References: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Just make the script more readable. Nobody is using 10 years old
git.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tools/git-version-gen | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/tools/git-version-gen b/tools/git-version-gen
index 1df20c3..3e431ef 100755
--- a/tools/git-version-gen
+++ b/tools/git-version-gen
@@ -111,27 +111,6 @@ elif test "`git log -1 --pretty=format:x . 2>&1`" = x \
          *) (exit 1) ;;
        esac
 then
-    # Is this a new git that lists number of commits since the last
-    # tag or the previous older version that did not?
-    #   Newer: v6.10-77-g0f8faeb
-    #   Older: v6.10-g0f8faeb
-    case $v in
-        *-rc[0-9]) ;; # release candidate
-        *-*-*) : git describe is okay three part flavor ;;
-        *-*)
-            : git describe is older two part flavor
-            # Recreate the number of commits and rewrite such that the
-            # result is the same as if we were using the newer version
-            # of git describe.
-            vtag=`echo "$v" | sed 's/-.*//'`
-            commit_list=`git rev-list "$vtag"..HEAD 2>/dev/null` \
-                || { commit_list=failed;
-                     echo "$0: WARNING: git rev-list failed" 1>&2; }
-            numcommits=`echo "$commit_list" | wc -l`
-            v=`echo "$v" | sed "s/\(.*\)-\(.*\)/\1-$numcommits-\2/"`;
-            test "$commit_list" = failed && v=UNKNOWN
-            ;;
-    esac
 
     case $v in
         *-rc[0-9])
-- 
1.8.5.6

