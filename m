Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:59280 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429AbaHKUYK (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Aug 2014 16:24:10 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] docs: improve the description of --size in the man page of zramctl
Date: Mon, 11 Aug 2014 22:23:39 +0200
Message-Id: <1407788619-4298-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/zramctl.8 |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
index a308233..6f82ccf 100644
--- a/sys-utils/zramctl.8
+++ b/sys-utils/zramctl.8
@@ -67,15 +67,10 @@ Reset the options of the specified zram device(s).  Zram device settings
 can be changed only after a reset.
 .TP
 .BR \-s , " \-\-size " \fIsize
-Force the zram driver to reread the size of the file associated with
-the specified zram device.  When not specified the
-.I size
-unit is bytes.  The zram devices size is page size aligned.  When
-requested
-.I size
-does match with page size the device be large enough to hold the reqested
-.I size
-plus length to next page boundary.
+Create a zram device of the specified \fIsize\fR.
+Zram devices are aligned to memory pages; when the requested \fIsize\fR is
+not a multiple of the page size, it will be rounded up to the next multiple.
+When not otherwise specified, the unit of the \fIsize\fR parameter is bytes.
 .IP
 The \fIsize\fR argument may be followed by the multiplicative suffixes KiB (=1024),
 MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB"
-- 
1.7.0.4

