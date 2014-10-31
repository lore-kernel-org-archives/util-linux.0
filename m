Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.187]:57281 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761087AbaJaHWQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 31 Oct 2014 03:22:16 -0400
From: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org
Cc: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH] findmnt: document --uniq option in man page
Date: Fri, 31 Oct 2014 08:22:00 +0100
Message-Id: <1414740120-25928-1-git-send-email-mail@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* misc-utils/findmnt.8: Add an entry for the -U, --uniq option
added in commit v2.24-132-gbebdda3.
---
 misc-utils/findmnt.8 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index ac5d908..a6318ed 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -198,6 +198,10 @@ to specify the filesystem types on which no action should be taken.  For
 more details see
 .BR mount (8).
 .TP
+.BR \-U , " \-\-uniq"
+Ignore filesystems with duplicate mount targets, thus effectively skipping
+over-mounted mount points.
+.TP
 .BR \-u , " \-\-notruncate"
 Do not truncate text in columns.  The default is to not truncate the
 .BR TARGET ,
-- 
1.8.4.5

