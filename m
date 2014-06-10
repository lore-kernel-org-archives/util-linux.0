Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:53712 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbaFJKIy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jun 2014 06:08:54 -0400
Received: from tenfore.ga-group.nl ([77.185.92.122]) by mail.gmx.com
 (mrgmx103) with ESMTPSA (Nemesis) id 0MZD0K-1XCvnc2jZk-00L0He for
 <util-linux@vger.kernel.org>; Tue, 10 Jun 2014 12:08:52 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] build-sys: use gettext 0.18.3 if possible
Date: Tue, 10 Jun 2014 12:08:51 +0200
Message-Id: <1402394931-20416-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de>
References: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We add a little hack for backward compatibility on systems with
older gettext installed

See 0576dbd3 and 81ed13ed.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 autogen.sh   | 31 ++++++++++++++++++++++++++++++-
 configure.ac |  3 ++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/autogen.sh b/autogen.sh
index 48e26ad..7bbcc75 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -13,6 +13,34 @@ THEDIR=`pwd`
 cd $srcdir
 DIE=0
 
+autopoint_fun ()
+{
+	# we have to deal with set -e ...
+	rm -f configure.ac.autogenbak
+	ret="0"
+	GT_VER_MIN="0.18"
+	GT_VER_DEF=$(sed -n 's/AM_GNU_GETTEXT_VERSION(\[\(.*\)\])/\1/p' configure.ac)
+	GT_VER_HAVE="$(gettext --version | head -n 1 | sed 's/.* //g')"
+
+	tmp=$(echo -e "$GT_VER_MIN\n$GT_VER_HAVE" | sort -V | tail -n1)
+	tmp=$(echo -e "$GT_VER_DEF\n$tmp" | sort -V | head -n1)
+
+	if [ "$tmp" != "$GT_VER_DEF" ]; then
+		echo "warning, force autopoint to use old gettext $tmp"
+		sed -i.autogenbak configure.ac \
+			-e "s/\(AM_GNU_GETTEXT_VERSION\).*/\1([$tmp])/"
+	fi
+
+	autopoint "$@" || ret=$?
+	ret=$?
+
+	if [ "$tmp" != "$GT_VER_DEF" ]; then
+		mv configure.ac.autogenbak configure.ac
+	fi
+
+	return $ret
+}
+
 test -f sys-utils/mount.c || {
 	echo
 	echo "You must run this script in the top-level util-linux directory"
@@ -66,6 +94,7 @@ fi
 
 echo
 echo "Generate build-system by:"
+
 echo "   autopoint:  $(autopoint --version | head -1)"
 echo "   aclocal:    $(aclocal --version | head -1)"
 echo "   autoconf:   $(autoconf --version | head -1)"
@@ -77,7 +106,7 @@ rm -rf autom4te.cache
 
 set -e
 po/update-potfiles
-autopoint --force $AP_OPTS
+autopoint_fun --force $AP_OPTS
 if ! grep -q datarootdir po/Makefile.in.in; then
 	echo autopoint does not honor dataroot variable, patching.
 	sed -i -e 's/^datadir *=\(.*\)/datarootdir = @datarootdir@\
diff --git a/configure.ac b/configure.ac
index 107184b..ba31abc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -152,7 +152,8 @@ UL_SET_ARCH([HPPA], [hppa*])
 
 AC_SYS_LARGEFILE
 
-AM_GNU_GETTEXT_VERSION([0.18])
+dnl we want this gettext version but still allow older ones via autogen.sh
+AM_GNU_GETTEXT_VERSION([0.18.3])
 AM_GNU_GETTEXT([external])
 
 AS_IF([test -d "$srcdir/po"], [
-- 
1.8.4.5

