Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46240 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbBXRYe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 12:24:34 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH 2/8] scriptreplay.1: fix spelling overide -> override
Date: Tue, 24 Feb 2015 12:15:17 -0500
Message-Id: <1424798123-11044-3-git-send-email-wfp5p@worldbroken.com>
In-Reply-To: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

Signed-off-by: Bill Pemberton <wfp5p@worldbroken.com>
---
 term-utils/scriptreplay.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index 8c9053aed80f..312573cf6fee 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -42,7 +42,7 @@ For example, a speed-up of 2 makes
 go twice as fast, and a speed-up of 0.1 makes it go ten times slower
 than the original session.
 .SH OPTIONS
-The first three options will overide old-style arguments.
+The first three options will override old-style arguments.
 .TP
 .BR \-t , " \-\-timing " \fIfile\fR
 File containing \fBscript\fR's timing output.
-- 
2.1.0

