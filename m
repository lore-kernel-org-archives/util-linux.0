Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:49855 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab3BJVdv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Feb 2013 16:33:51 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so4317633wge.22
        for <util-linux@vger.kernel.org>; Sun, 10 Feb 2013 13:33:49 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/3] build-sys: add package url to AC_INIT
Date: Sun, 10 Feb 2013 21:33:41 +0000
Message-Id: <1360532021-23647-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1360532021-23647-1-git-send-email-kerolasa@iki.fi>
References: <1360532021-23647-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

See last line from './configure --help'.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index df0e9a9..5154612 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,6 +1,7 @@
 AC_INIT(util-linux,
 	m4_esyscmd([tools/git-version-gen .tarball-version]),
-	kzak@redhat.com)
+	[kzak@redhat.com],,
+	[http://www.kernel.org/pub/linux/utils/util-linux/])
 
 AC_PREREQ(2.60)
 
-- 
1.8.1.3

