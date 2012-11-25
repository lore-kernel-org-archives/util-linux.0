Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49064 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab2KYMBV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 Nov 2012 07:01:21 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so1492723wgb.1
        for <util-linux@vger.kernel.org>; Sun, 25 Nov 2012 04:01:20 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: =?UTF-8?q?=5BPATCH=203/4=5D=20docs=3A=20mention=20what=20Open=20Group=20has=20marked=20legacy?=
Date: Sun, 25 Nov 2012 12:01:10 +0000
Message-Id: <1353844871-6047-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1353844871-6047-1-git-send-email-kerolasa@iki.fi>
References: <1353844871-6047-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/deprecated.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index 2d43cb0..8bb8a49 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -58,3 +58,15 @@ Why:	deprecated in favor of uname(1) or arch(1) from coreutils
 What:	last(1)
 Why:	nobody uses this implementation
 
+----------------------------
+
+The Single UNIX ® Specification, Version 2
+Copyright © 1997 The Open Group
+
+  Legacy utilities which are part util-linux package are:
+
+	col
+	line
+	pg
+
+  http://pubs.opengroup.org/onlinepubs/7908799/xcu/intro.html#tag_001_003_003
-- 
1.8.0

