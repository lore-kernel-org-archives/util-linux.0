Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:51034 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab3KJUGP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 15:06:15 -0500
Received: by mail-we0-f175.google.com with SMTP id p61so1218648wes.6
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 12:06:14 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/2] docs: add patching process to howto-contribute.txt
Date: Sun, 10 Nov 2013 20:06:09 +0000
Message-Id: <1384113970-2558-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/howto-contribute.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/howto-contribute.txt b/Documentation/howto-contribute.txt
index f0b64ef..5f4531e 100644
--- a/Documentation/howto-contribute.txt
+++ b/Documentation/howto-contribute.txt
@@ -88,6 +88,29 @@ Coding style
 	  something is not quite right, and you are unwilling to fix the
 	  issue.
 
+Patching process
+
+	* Tell in mail list when you are going to work with some particular
+	  piece of code for long time.  This helps other to avoid massive
+	  merge conflicts.  Small or quick work does not need to be
+	  announced.
+
+	* Submit only changes that you think are ready to merge.  If you only
+	  want change review tell your intention clearly in change cover
+	  letter, and/or in each patch subject to review-only.
+
+	* When getting comments align the changes with them.  Resubmission
+	  without changes is as good as ignoring advice, and is neither
+	  recommended nor polite.
+
+	* Resubmission can be partial or complete.  If only few alterations
+	  are needed here and there resubmit particular patches.  When
+	  comments cause greater effect resubmit everything again.
+
+	* All patch submissions, big or small, are either commented, reject,
+	  or merge.  When maintainer rejects a patch (series) it is pointless
+	  to resubmit.
+
 Various notes
 
 	* The util-linux does not use kernel headers for file system super
-- 
1.8.4.2

