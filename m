Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:64289 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460Ab2JNUWr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:47 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680717wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/13] docs: update TODO
Date: Sun, 14 Oct 2012 21:22:25 +0100
Message-Id: <1350246145-10600-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/TODO | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index a646127..4735a27 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -182,10 +182,6 @@ misc
 
  - add mllockall() and SCHED_FIFO to hwclock,
    see http://lkml.org/lkml/2008/10/12/132
- 
- - (!) rewrite ipcs to use /proc/sys/kernel rather than unreliable syscalls
-   (there are problems with 32bit userspace on 64bit kernel)
-
 
 ---------------
 exotic requests
-- 
1.7.12.3

