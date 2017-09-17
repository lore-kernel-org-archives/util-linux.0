Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35277 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdIQStJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 17 Sep 2017 14:49:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id e64so6943594wmi.2
        for <util-linux@vger.kernel.org>; Sun, 17 Sep 2017 11:49:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] tools: update git-version-gen from gnulib
Date: Sun, 17 Sep 2017 19:49:01 +0100
Message-Id: <20170917184902.1218-2-kerolasa@iki.fi>
In-Reply-To: <20170917184902.1218-1-kerolasa@iki.fi>
References: <20170917184902.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

from-gnulib-commit: e277cd7c6cf6435d9d4d380fd6cef0510e3f5afe
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tools/git-version-gen | 137 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 102 insertions(+), 35 deletions(-)

diff --git a/tools/git-version-gen b/tools/git-version-gen
index b287cb794..0e254f4be 100755
--- a/tools/git-version-gen
+++ b/tools/git-version-gen
@@ -1,8 +1,8 @@
 #!/bin/sh
 # Print a version string.
-scriptversion=2011-02-19.19; # UTC
+scriptversion=2017-09-13.06; # UTC
 
-# Copyright (C) 2007-2011 Free Software Foundation, Inc.
+# Copyright (C) 2007-2017 Free Software Foundation, Inc.
 #
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -15,9 +15,9 @@ scriptversion=2011-02-19.19; # UTC
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+# along with this program.  If not, see <https://www.gnu.org/licenses/>.
 
-# This script is derived from GIT-VERSION-GEN from GIT: http://git.or.cz/.
+# This script is derived from GIT-VERSION-GEN from GIT: https://git-scm.com/.
 # It may be run two ways:
 # - from a git repository in which the "git describe" command below
 #   produces useful output (thus requiring at least one signed tag)
@@ -44,8 +44,10 @@ scriptversion=2011-02-19.19; # UTC
 #   files to pick up a version string change; and leave it stale to
 #   minimize rebuild time after unrelated changes to configure sources.
 #
-# It is probably wise to add these two files to .gitignore, so that you
-# don't accidentally commit either generated file.
+# As with any generated file in a VC'd directory, you should add
+# /.version to .gitignore, so that you don't accidentally commit it.
+# .tarball-version is never generated in a VC'd directory, so needn't
+# be listed there.
 #
 # Use the following line in your configure.ac, so that $(VERSION) will
 # automatically be up-to-date each time configure is run (and note that
@@ -57,24 +59,74 @@ scriptversion=2011-02-19.19; # UTC
 #         [bug-project@example])
 #
 # Then use the following lines in your Makefile.am, so that .version
-# will be present for dependencies, and so that .tarball-version will
-# exist in distribution tarballs.
+# will be present for dependencies, and so that .version and
+# .tarball-version will exist in distribution tarballs.
 #
+# EXTRA_DIST = $(top_srcdir)/.version
 # BUILT_SOURCES = $(top_srcdir)/.version
 # $(top_srcdir)/.version:
 #	echo $(VERSION) > $@-t && mv $@-t $@
 # dist-hook:
 #	echo $(VERSION) > $(distdir)/.tarball-version
 
-case $# in
-    1|2) ;;
-    *) echo 1>&2 "Usage: $0 \$srcdir/.tarball-version" \
-         '[TAG-NORMALIZATION-SED-SCRIPT]'
-       exit 1;;
-esac
 
-tarball_version_file=$1
-tag_sed_script="${2:-s/x/x/}"
+me=$0
+
+version="git-version-gen $scriptversion
+
+Copyright 2011 Free Software Foundation, Inc.
+There is NO warranty.  You may redistribute this software
+under the terms of the GNU General Public License.
+For more information about these matters, see the files named COPYING."
+
+usage="\
+Usage: $me [OPTION]... \$srcdir/.tarball-version [TAG-NORMALIZATION-SED-SCRIPT]
+Print a version string.
+
+Options:
+
+   --prefix PREFIX    prefix of git tags (default 'v')
+   --fallback VERSION
+                      fallback version to use if \"git --version\" fails
+
+   --help             display this help and exit
+   --version          output version information and exit
+
+Running without arguments will suffice in most cases."
+
+prefix=v
+fallback=
+
+while test $# -gt 0; do
+  case $1 in
+    --help) echo "$usage"; exit 0;;
+    --version) echo "$version"; exit 0;;
+    --prefix) shift; prefix=${1?};;
+    --fallback) shift; fallback=${1?};;
+    -*)
+      echo "$0: Unknown option '$1'." >&2
+      echo "$0: Try '--help' for more information." >&2
+      exit 1;;
+    *)
+      if test "x$tarball_version_file" = x; then
+        tarball_version_file="$1"
+      elif test "x$tag_sed_script" = x; then
+        tag_sed_script="$1"
+      else
+        echo "$0: extra non-option argument '$1'." >&2
+        exit 1
+      fi;;
+  esac
+  shift
+done
+
+if test "x$tarball_version_file" = x; then
+    echo "$usage"
+    exit 1
+fi
+
+tag_sed_script="${tag_sed_script:-s/x/x/}"
+
 nl='
 '
 
@@ -92,49 +144,64 @@ then
         [0-9]*) ;;
         *) v= ;;
     esac
-    test -z "$v" \
+    test "x$v" = x \
         && echo "$0: WARNING: $tarball_version_file is missing or damaged" 1>&2
 fi
 
-if test -n "$v"
+if test "x$v" != x
 then
     : # use $v
 # Otherwise, if there is at least one git commit involving the working
 # directory, and "git describe" output looks sensible, use that to
 # derive a version string.
 elif test "`git log -1 --pretty=format:x . 2>&1`" = x \
-    && v=`git describe --abbrev=4 --match='v*' HEAD 2>/dev/null \
+    && v=`git describe --abbrev=4 --match="$prefix*" HEAD 2>/dev/null \
           || git describe --abbrev=4 HEAD 2>/dev/null` \
     && v=`printf '%s\n' "$v" | sed "$tag_sed_script"` \
     && case $v in
-         v[0-9]*) ;;
+         $prefix[0-9]*) ;;
          *) (exit 1) ;;
        esac
 then
-
-    # Remove the "g" in git describe's output string, to save a byte.
-    v=`echo "$v" | sed 's/-g/-/'`;
-
-    case $v in
-        *-rc*)
-            ;;
+    # Is this a new git that lists number of commits since the last
+    # tag or the previous older version that did not?
+    #   Newer: v6.10-77-g0f8faeb
+    #   Older: v6.10-g0f8faeb
+    vprefix=`expr "X$v" : 'X\(.*\)-g[^-]*$'` || vprefix=$v
+    case $vprefix in
+        *-*) : git describe is probably okay three part flavor ;;
         *)
-            # Change the first '-' to a '.', so version-comparing tools work properly.
-            v=`echo "$v" | sed 's/-/./'`;
+            : git describe is older two part flavor
+            # Recreate the number of commits and rewrite such that the
+            # result is the same as if we were using the newer version
+            # of git describe.
+            vtag=`echo "$v" | sed 's/-.*//'`
+            commit_list=`git rev-list "$vtag"..HEAD 2>/dev/null` \
+                || { commit_list=failed;
+                     echo "$0: WARNING: git rev-list failed" 1>&2; }
+            numcommits=`echo "$commit_list" | wc -l`
+            v=`echo "$v" | sed "s/\(.*\)-\(.*\)/\1-$numcommits-\2/"`;
+            test "$commit_list" = failed && v=UNKNOWN
             ;;
     esac
+
+    # Change the penultimate "-" to ".", for version-comparing tools.
+    # Remove the "g" to save a byte.
+    v=`echo "$v" | sed 's/-\([^-]*\)-g\([^-]*\)$/.\1-\2/'`;
     v_from_git=1
-else
+elif test "x$fallback" = x || git --version >/dev/null 2>&1; then
     v=UNKNOWN
+else
+    v=$fallback
 fi
 
-v=`echo "$v" |sed 's/^v//'`
+v=`echo "$v" |sed "s/^$prefix//"`
 
 # Test whether to append the "-dirty" suffix only if the version
 # string we're using came from git.  I.e., skip the test if it's "UNKNOWN"
 # or if it came from .tarball-version.
-if test -n "$v_from_git"; then
-  # Don't declare a version "dirty" merely because a time stamp has changed.
+if test "x$v_from_git" != x; then
+  # Don't declare a version "dirty" merely because a timestamp has changed.
   git update-index --refresh > /dev/null 2>&1
 
   dirty=`exec 2>/dev/null;git diff-index --name-only HEAD` || dirty=
@@ -149,12 +216,12 @@ if test -n "$v_from_git"; then
 fi
 
 # Omit the trailing newline, so that m4_esyscmd can use the result directly.
-echo "$v" | tr -d "$nl"
+printf %s "$v"
 
 # Local variables:
 # eval: (add-hook 'write-file-hooks 'time-stamp)
 # time-stamp-start: "scriptversion="
 # time-stamp-format: "%:y-%02m-%02d.%02H"
-# time-stamp-time-zone: "UTC"
+# time-stamp-time-zone: "UTC0"
 # time-stamp-end: "; # UTC"
 # End:
-- 
2.14.1

