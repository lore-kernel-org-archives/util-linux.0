Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61168 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758549Ab2CIScr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Mar 2012 13:32:47 -0500
Received: by vbbff1 with SMTP id ff1so1649153vbb.19
        for <util-linux@vger.kernel.org>; Fri, 09 Mar 2012 10:32:47 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/2] lsblk.8: RQ-SIZE is part of the --topology output
Date: Fri,  9 Mar 2012 13:32:43 -0500
Message-Id: <1331317964-29267-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/lsblk.8 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 64cf4a9..a5146e4 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -59,7 +59,7 @@ Use key="value" output format. All potentially unsafe characters are hex-escaped
 Use the raw output format. All potentially unsafe characters are hex-escaped (\\x<code>).
 .IP "\fB\-t, \-\-topology\fP"
 Output info about block device topology.
-This option is equivalent to "-o NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,ROTA,SCHED".
+This option is equivalent to "-o NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,ROTA,SCHED,RQ-SIZE".
 .IP "\fB\-V, \-\-version\fP"
 Output version information and exit.
 .SH NOTES
-- 
1.7.9.3

