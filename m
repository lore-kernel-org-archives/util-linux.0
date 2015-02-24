Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46237 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbbBXRYe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 12:24:34 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH 1/8] runuser.1: fix spelling implemenation -> implementation
Date: Tue, 24 Feb 2015 12:15:16 -0500
Message-Id: <1424798123-11044-2-git-send-email-wfp5p@worldbroken.com>
In-Reply-To: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

Signed-off-by: Bill Pemberton <wfp5p@worldbroken.com>
---
 login-utils/runuser.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 1fec182c8f50..0672cd66d335 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -225,7 +225,7 @@ global logindef config file
 .BR su (1)
 .SH HISTORY
 This \fB runuser\fR command was
-derived from coreutils' \fBsu\fR, which was based on an implemenation by
+derived from coreutils' \fBsu\fR, which was based on an implementation by
 David MacKenzie, and the Fedora \fBrunuser\fR command by Dan Walsh.
 .SH AVAILABILITY
 The runuser command is part of the util-linux package and is
-- 
2.1.0

