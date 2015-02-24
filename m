Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46238 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbbBXRYe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 12:24:34 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH 7/8] prlimit.1: fix typo umlimited -> unlimited
Date: Tue, 24 Feb 2015 12:15:22 -0500
Message-Id: <1424798123-11044-8-git-send-email-wfp5p@worldbroken.com>
In-Reply-To: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

---
 sys-utils/prlimit.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index e5c2071569f4..600c706fcb32 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -99,7 +99,7 @@ of open files to 1024 and 4095, respectively.
 Modify only the soft limit for the number of processes.
 .IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
 Set for the current process both the soft and ceiling values for the number of
-processes to umlimited.
+processes to unlimited.
 .IP "\fBprlimit --cpu=10 sort -u hugefile\fP"
 Set both the soft and hard CPU time limit to ten seconds and run 'sort'.
 
-- 
2.1.0

