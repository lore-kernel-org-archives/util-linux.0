Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35308 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbcEORbL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 May 2016 13:31:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so13477556wme.2
        for <util-linux@vger.kernel.org>; Sun, 15 May 2016 10:31:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/11] docs: remove timestamp TODO item
Date: Sun, 15 May 2016 18:30:52 +0100
Message-Id: <1463333457-1011-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
References: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/TODO | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index af00ab3..416aaed 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -1,8 +1,6 @@
 
  Note that items with (!) have high priority.
 
-- add functions strtime_short(), strtime_iso(), strtime_ctime(), ...
-
 - cleanup lib/path.c:
    - always return rc from all functions
    - introduce control struct and use openat() from top-level path 
-- 
2.8.2

