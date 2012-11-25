Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49064 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab2KYMBS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 Nov 2012 07:01:18 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so1492723wgb.1
        for <util-linux@vger.kernel.org>; Sun, 25 Nov 2012 04:01:18 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: =?UTF-8?q?=5BPATCH=201/4=5D=20docs=3A=20mention=20Open=20Group=20requirements?=
Date: Sun, 25 Nov 2012 12:01:08 +0000
Message-Id: <1353844871-6047-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1353844871-6047-1-git-send-email-kerolasa@iki.fi>
References: <1353844871-6047-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commands cal col ipcrm ipcs kill line logger mesg more newgrp pg renice
has Open Group requirements.  Contributors need to be aware of them.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/howto-contribute.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/howto-contribute.txt b/Documentation/howto-contribute.txt
index 5df6389..e0f8ad7 100644
--- a/Documentation/howto-contribute.txt
+++ b/Documentation/howto-contribute.txt
@@ -117,6 +117,35 @@ Various notes
 	  multiple lines. In case the shorthand does not look good on one
 	  line use normal "if () else" syntax.
 
+Standards compliancy
+
+	Some of the commands maintained in this package has Open Group
+	requirements. These commands are;
+
+		cal
+		col
+		ipcrm
+		ipcs
+		kill
+		line
+		logger
+		mesg
+		more
+		newgrp
+		pg
+		renice
+
+	If you change these tools please make sure a change does not
+	conflict with the latest standard.  For example it is
+	recommendable not to add short command line options before they
+	are part of standard.  Introducing new short options is
+	acceptable.
+
+		The Single UNIX® Specification, Version 2
+		Copyright © 1997 The Open Group
+
+		http://pubs.opengroup.org/onlinepubs/7908799/xcuix.html
+
 IRC channel
 
 	* We have a new #util-linux IRC channel at freenode.net.
-- 
1.8.0

