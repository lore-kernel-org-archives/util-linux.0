Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:59198 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbcHOU0o (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Aug 2016 16:26:44 -0400
Date: Mon, 15 Aug 2016 22:26:30 +0200
From: Helge Deller <deller@gmx.de>
To: util-linux@vger.kernel.org
Cc: Ruediger Meier <ruediger.meier@ga-group.nl>, 827225@bugs.debian.org
Subject: [PATCH] tests: really fix fdisk/bsd for hppa
Message-ID: <20160815202630.GA14518@ls3530.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Finally fix the bsd testcase on the hppa architecture.

Commit 1b7be556e553cdcef6213ead6340832c306011ed tried to fix it,
but missed the fact that "uname -m" returns "parisc" or "parisc64"
instead of "hppa*".

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: 827225@bugs.debian.org

diff -up ./tests/ts/fdisk/bsd.org ./tests/ts/fdisk/bsd
--- ./tests/ts/fdisk/bsd.org	2016-08-15 22:16:24.849052620 +0200
+++ ./tests/ts/fdisk/bsd	2016-08-15 22:16:42.645094364 +0200
@@ -48,7 +48,7 @@ BYTE_ORDER=$($TS_HELPER_SYSINFO byte-ord
 ARCH=$(uname -m)
 case $ARCH in
 	# see include/pt-bsd.h
-	*alpha* | *ppc* | *ia64* | *hppa* )
+	*alpha* | *ppc* | *ia64* | *parisc* )
 		BSD_LABELSECTOR=0
 		BSD_LABELOFFSET=64
 		;;
