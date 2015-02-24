Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46245 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbbBXRYf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 12:24:35 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH 4/8] last.1: fix spelling preferrable -> preferable
Date: Tue, 24 Feb 2015 12:15:19 -0500
Message-Id: <1424798123-11044-5-git-send-email-wfp5p@worldbroken.com>
In-Reply-To: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

Signed-off-by: Bill Pemberton <wfp5p@worldbroken.com>
---
 login-utils/last.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/last.1 b/login-utils/last.1
index 23ebaf32e9ee..719a0ede9f2b 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -140,7 +140,7 @@ is the same as the
 option.  The
 .I iso
 variant will display the timestamp in ISO-8601 format.  The ISO format
-contains timezone information, making it preferrable when printouts are
+contains timezone information, making it preferable when printouts are
 investigated outside of the system.
 .TP
 .BR \-w , " \-\-fullnames"
-- 
2.1.0

