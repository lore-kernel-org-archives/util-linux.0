Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52553 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752930AbbCMTPZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Mar 2015 15:15:25 -0400
Message-ID: <55033747.5040305@gmx.com>
Date: Fri, 13 Mar 2015 15:15:19 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 2/5] hwclock: Improve FILES section
References: <5503364E.6010302@gmx.com>
In-Reply-To: <5503364E.6010302@gmx.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 65ab99a..51367a4 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -1052,10 +1052,19 @@ configured timezone.
 If this variable is set its value takes precedence over the system
 configured timezone database directory path.
 .SH FILES
-.br
+.TP
 .I @ADJTIME_PATH@
-.br
+The configuration and state file for hwclock.
+.TP
 .I /etc/localtime
+The system timezone file.
+.TP
+.I /usr/share/zoneinfo/
+The system timezone database directory.
+.PP
+Device files
+.B hwclock
+may try for Hardware Clock access:
 .br
 .I /dev/rtc
 .br
@@ -1070,9 +1079,6 @@ configured timezone database directory path.
 .I /dev/port
 .br
 .I /dev/tty1
-.br
-.I /proc/cpuinfo
-.
 .SH "SEE ALSO"
 .BR date (1),
 .BR adjtimex (8),
