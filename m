Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35120 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbbAGTZp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 7 Jan 2015 14:25:45 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so8746212wiv.0
        for <util-linux@vger.kernel.org>; Wed, 07 Jan 2015 11:25:44 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] docs: small improvements to howto-contribute.txt
Date: Wed,  7 Jan 2015 19:25:38 +0000
Message-Id: <1420658739-2713-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/howto-contribute.txt | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/howto-contribute.txt b/Documentation/howto-contribute.txt
index d9151d9..554d6b3 100644
--- a/Documentation/howto-contribute.txt
+++ b/Documentation/howto-contribute.txt
@@ -1,9 +1,7 @@
 Patches
 
 	* send your patches to the mailing list or to the upstream maintainer
-	  (see the AUTHORS and README files)
-
-	* diff -u
+	  (see the README file in project root directory).
 
 	* don't include generated (autotools) stuff to your patches (hint:
 	  use git clean -Xd)
@@ -17,12 +15,16 @@ Patches
 
 	* one patch per email, with the changelog in the body of the email.
 
+	* mail attachments are difficult. Tip:
+	  git send-email --to util-linux@vger.kernel.org origin/master..yourbranch
+
 	* many small patches are favoured over one big. Break down is done on
 	  basis of logical functionality; for example #endif mark ups,
 	  compiler warning and exit codes fixes all should be individual
 	  small patches.
 
-	* Subject: [PATCH] subsystem: description
+	* 'Subject: [PATCH] subsystem: description'. See also 'Patching
+	  process'.
 
 	* if someone else wrote the patch, they should be credited (and
 	  blamed) for it. To communicate this, add a line:
@@ -74,8 +76,8 @@ Before sending a patch
 	  errors.
 
 	* test that previously existed program behavior is not
-	  unintentionally alterred. If you alter the behavior tell about in
-	  commit message.
+	  unintentionally alterred. If you alter the behavior tell about
+	  it in commit message.
 
 Coding style
 
@@ -86,7 +88,7 @@ Coding style
 
 	* Use `FIXME:' and a good description if want to inform others
 	  something is not quite right, and you are unwilling to fix the
-	  issue.
+	  issue in the submitted change.
 
 Patching process
 
@@ -107,6 +109,9 @@ Patching process
 	  are needed here and there resubmit particular patches.  When
 	  comments cause greater effect resubmit everything again.
 
+	* Mark resubmission with [PATCH v2]. Hint:
+	  git format-patch origin/master..yourbranch --subject-prefix='PATCH v2'
+
 	* All patch submissions, big or small, are either commented, reject,
 	  or merge.  When maintainer rejects a patch (series) it is pointless
 	  to resubmit.
-- 
2.2.1

