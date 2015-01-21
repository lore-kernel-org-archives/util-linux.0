Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:58948 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbbAUSC6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Jan 2015 13:02:58 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0M23zf-1Xt9eF0zv9-00u0uK for
 <util-linux@vger.kernel.org>; Wed, 21 Jan 2015 19:02:56 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/5] tests: python tests should not remove user's LD_LIBRARY_PATH
Date: Wed, 21 Jan 2015 19:02:50 +0100
Message-Id: <1421863374-9953-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
References: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

LD_LIBRARY_PATH must be preserved like it's done in libtool's
temporary wrapper scripts.

This problem was noticed when building with Intel's icc (15.0.0):
$ make check TS_OPTS="libmount"
$ tail tests/diff/libmount/tabfiles-py-parse-mtab
[...]
+Traceback (most recent call last):
+  File "/tmp/util-linux/libmount/python/test_mount_tab.py", line 8, in <module>
+    import pylibmount as mnt
+ImportError: libimf.so: cannot open shared object file: No such file or directory

... although libimf.so was in LD_LIBRARY_PATH.

NOTE 1:
  When running root checks "sudo -E" is not enough to preserve
  LD_LIBRARY_PATH because glibc already removes is. This would work:
  $ sudo -E env LD_LIBRARY_PATH=$LD_LIBRARY_PATH make check TS_OPTS="--parallel=1"

NOTE 2:
  We also preserve PYTHONPATH which could bring us similar problems if
  the user has a customized python installation.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index a9b3758..852a6a3 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -332,8 +332,8 @@ function ts_init_py {
 
 	[ -f "$top_builddir/py${LIBNAME}.la" ] || ts_skip "py${LIBNAME} not compiled"
 
-	export LD_LIBRARY_PATH="$top_builddir/.libs"
-	export PYTHONPATH="$top_builddir/$LIBNAME/python:$top_builddir/.libs"
+	export LD_LIBRARY_PATH="$top_builddir/.libs:$LD_LIBRARY_PATH"
+	export PYTHONPATH="$top_builddir/$LIBNAME/python:$top_builddir/.libs:$PYTHONPATH"
 
 	export PYTHON_VERSION=$(awk '/^PYTHON_VERSION/ { print $3 }' $top_builddir/Makefile)
 	export PYTHON_MAJOR_VERSION=$(echo $PYTHON_VERSION | sed 's/\..*//')
-- 
1.8.4.5

