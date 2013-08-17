Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:62552 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSPk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:15:40 -0400
Received: by mail-we0-f173.google.com with SMTP id x54so1455014wes.32
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:15:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/16] build-sys: remove unnecessary environment variable
Date: Sat, 17 Aug 2013 19:15:06 +0100
Message-Id: <1376763321-22782-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The addition to original removal done in commit 952f1d79.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 autogen.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/autogen.sh b/autogen.sh
index 2bcbda7..48e26ad 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -12,7 +12,6 @@ test -z "$srcdir" && srcdir=.
 THEDIR=`pwd`
 cd $srcdir
 DIE=0
-HAS_GTKDOC=1
 
 test -f sys-utils/mount.c || {
 	echo
-- 
1.8.3.4

