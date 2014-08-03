Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:43849 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbaHCORv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 10:17:51 -0400
Received: by mail-we0-f174.google.com with SMTP id x48so6427880wes.5
        for <util-linux@vger.kernel.org>; Sun, 03 Aug 2014 07:17:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/7] docs: add details to zramctl --size option documentation
Date: Sun,  3 Aug 2014 15:17:38 +0100
Message-Id: <1407075463-19586-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/zramctl.8 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
index 74240a1..a308233 100644
--- a/sys-utils/zramctl.8
+++ b/sys-utils/zramctl.8
@@ -68,8 +68,15 @@ can be changed only after a reset.
 .TP
 .BR \-s , " \-\-size " \fIsize
 Force the zram driver to reread the size of the file associated with
-the specified zram device
-
+the specified zram device.  When not specified the
+.I size
+unit is bytes.  The zram devices size is page size aligned.  When
+requested
+.I size
+does match with page size the device be large enough to hold the reqested
+.I size
+plus length to next page boundary.
+.IP
 The \fIsize\fR argument may be followed by the multiplicative suffixes KiB (=1024),
 MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB"
 is optional, e.g., "K" has the same meaning as "KiB") or the suffixes
-- 
2.0.3

