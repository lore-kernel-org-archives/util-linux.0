Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46244 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbbBXRYf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 12:24:35 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH 3/8] unshare.1: fix spelling permamently -> permanently
Date: Tue, 24 Feb 2015 12:15:18 -0500
Message-Id: <1424798123-11044-4-git-send-email-wfp5p@worldbroken.com>
In-Reply-To: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

Signed-off-by: Bill Pemberton <wfp5p@worldbroken.com>
---
 sys-utils/unshare.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index f5975d1803b2..99a0d0ae49d7 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -96,7 +96,7 @@ until after GID map has been set. The GID map is writable by root when
 .BR setgroups(2)
 is enabled and GID map becomes writable by unprivileged processes when
 .BR setgroups(2)
-is permamently disabled.
+is permanently disabled.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-- 
2.1.0

