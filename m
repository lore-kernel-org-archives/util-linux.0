Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35237 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbbF1Tnf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jun 2015 15:43:35 -0400
Received: by wgjx7 with SMTP id x7so51969986wgj.2
        for <util-linux@vger.kernel.org>; Sun, 28 Jun 2015 12:43:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/7] build-sys: add minimal whitespace build directory support
Date: Sun, 28 Jun 2015 20:43:23 +0100
Message-Id: <1435520605-4296-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
References: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The commit fixes following issue.

$ ./autogen.sh
[...]
./autogen.sh: line 119: cd: /home/src/util: No such file or directory

And makes build to fail early with an error easier to understand than the
one below.

$ make
[...]
./libtool: line 8988: cd: linux: No such file or directory
libtool: warning: cannot determine absolute directory name of 'linux'
/usr/bin/grep: linux/libuuid.la: No such file or directory
/usr/bin/sed: can't read linux/libuuid.la: No such file or directory
libtool:   error: 'linux/libuuid.la' is not a valid libtool archive

Reference: https://lists.gnu.org/archive/html/bug-libtool/2005-03/msg00132.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 autogen.sh   | 7 ++++++-
 configure.ac | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/autogen.sh b/autogen.sh
index 546d468..d64ff08 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -86,6 +86,11 @@ test ${ltver##2.} = "$ltver" && {
 	DIE=1
 }
 
+if test `echo $PWD | grep -c '\s'` != "0"; then
+	echo 'built directory cannot have whitespace in its name.'
+	DIE=1
+fi
+
 if test "$DIE" -eq 1; then
 	exit 1
 fi
@@ -116,7 +121,7 @@ autoheader $AH_OPTS
 
 automake --add-missing $AM_OPTS
 
-cd $THEDIR
+cd "$THEDIR"
 
 echo
 echo "Now type '$srcdir/configure' and 'make' to compile."
diff --git a/configure.ac b/configure.ac
index 58feb22..18bee8c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -142,6 +142,11 @@ m4_ifndef([PKG_PROG_PKG_CONFIG],
     ./autogen.sh or autoreconf again.])])
 PKG_PROG_PKG_CONFIG
 
+dnl libtool does not work if the path has a space in it.
+AS_IF([ test `echo $PWD | grep -c '\s'` != "0"  ], [
+  AC_MSG_ERROR([built directory cannot have whitespace in its name.])
+])
+
 GTK_DOC_CHECK([1.10])
 AC_PATH_PROG([XSLTPROC], [xsltproc])
 
-- 
2.4.4

