Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59027 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab1IQVW3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Sep 2011 17:22:29 -0400
Received: by qyk30 with SMTP id 30so1583099qyk.19
        for <util-linux@vger.kernel.org>; Sat, 17 Sep 2011 14:22:28 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] blkid.8: fix unfinished sentence for -l option.
Date: Sat, 17 Sep 2011 17:20:47 -0400
Message-Id: <1316294447-26330-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/blkid.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index c797afa..c8794a3 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -101,7 +101,7 @@ Display I/O Limits (aka I/O topology) information.  The 'export' output format i
 automatically enabled.  This option can be used together with the \fB-p\fR option.
 .TP
 .B \-l
-Look up only one device that matches the search parameter specified with the
+Look up only one device that matches the search parameter specified with \fB-t\fR.
 .TP
 .B \-k
 List all known filesystems and RAIDs and exit.
-- 
1.7.6.1

