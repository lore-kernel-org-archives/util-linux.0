Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50375 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbbCMTLU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Mar 2015 15:11:20 -0400
Message-ID: <5503364E.6010302@gmx.com>
Date: Fri, 13 Mar 2015 15:11:10 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 1/5] hwclock: add TZDIR
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add information about TZDIR and improve the
ENVIRONMENT section.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index fbc10ca..65ab99a 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -1039,11 +1039,18 @@ time conversion.
 Attempting to mix and match files from these separate databases will not
 work, because they each require the System Clock to use a different
 timescale. The zoneinfo database must be configured to use either posix
-or 'right', as described above.
-.
-.SH "ENVIRONMENT VARIABLES"
-.I TZ
-.
+or 'right', as described above, or by assigning a database path to the
+.SB TZDIR
+environment variable.
+.SH ENVIRONMENT
+.TP
+.B TZ
+If this variable is set its value takes precedence over the system
+configured timezone.
+.TP
+.B TZDIR
+If this variable is set its value takes precedence over the system
+configured timezone database directory path.
 .SH FILES
 .br
 .I @ADJTIME_PATH@
