Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38491 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbeBZMPj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 26 Feb 2018 07:15:39 -0500
Received: by mail-pf0-f193.google.com with SMTP id d26so6416444pfn.5
        for <util-linux@vger.kernel.org>; Mon, 26 Feb 2018 04:15:39 -0800 (PST)
From: Masanari Iida <standby24x7@gmail.com>
To: util-linux@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] blkzone: Fix a typo in blkzone.8
Date: Mon, 26 Feb 2018 21:15:33 +0900
Message-Id: <20180226121533.11379-1-standby24x7@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch fixes a spelling typo in blkzone.8

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sys-utils/blkzone.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/blkzone.8 b/sys-utils/blkzone.8
index 460950850936..5d99f9461ec2 100644
--- a/sys-utils/blkzone.8
+++ b/sys-utils/blkzone.8
@@ -83,7 +83,7 @@ used together with the option \fB\-\-count\fP.
 .TP
 .BR \-c , " \-\-count "\fIcount\fP
 The maximum number of zones the command should operate on. The default value
-is the nuber of zones starting from \fIoffset\fR. This option cannot be
+is the number of zones starting from \fIoffset\fR. This option cannot be
 used together with the option \fB\-\-length\fP.
 .TP
 .BR \-v , " \-\-verbose"
-- 
2.16.2.246.ga4ee44448fe9

