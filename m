Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46243 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbbBXRYf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 12:24:35 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH 5/8] lslogins.1: fix spelling priviliges -> privileges
Date: Tue, 24 Feb 2015 12:15:20 -0500
Message-Id: <1424798123-11044-6-git-send-email-wfp5p@worldbroken.com>
In-Reply-To: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

Signed-off-by: Bill Pemberton <wfp5p@worldbroken.com>
---
 login-utils/lslogins.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index fd1c66157410..ad52936a48dd 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -20,7 +20,7 @@ Mandatory arguments to long options are mandatory for short options too.
 .TP
 \fB\-a\fR, \fB\-\-acc\-expiration\fR
 Display data about the date of last password change and the account expiration
-date (see \fBshadow\fR(5) for more info).  (Requires root priviliges.)
+date (see \fBshadow\fR(5) for more info).  (Requires root privileges.)
 .TP
 \fB\-\-btmp\-file \fIpath\fP
 Alternate path for btmp.
-- 
2.1.0

