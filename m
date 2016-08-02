Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33068 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757329AbcHBSeD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 14:34:03 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 24C70ACAC
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2016 17:59:58 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 7/8] losetup.8: Update losetup documentation
Message-ID: <3f914b15-b9e9-37a1-bd7e-981aef165adc@suse.cz>
Date: Tue, 2 Aug 2016 19:59:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Document loop re-use, conflict checks and --force.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/losetup.8 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index b614416..9924031 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -64,6 +64,7 @@ is used to associate loop devices with regular files or block devices,
 to detach loop devices, and to query the status of a loop device.  If only the
 \fIloopdev\fP argument is given, the status of the corresponding loop
 device is shown.  If no option is given, all loop devices are shown.
+To prevent data loss, return error if an overlaying device exists.
 .sp
 Note that the old output format (i.e. \fBlosetup -a\fR) with comma-delimited
 strings is deprecated in favour of the \fB--list\fR output format.
@@ -101,6 +102,20 @@ Find the first unused loop device.  If a
 .I file
 argument is present, use the found device as loop device.
 Otherwise, just print its name.
+
+Since util-linux v2.29 \fI--find\fP command re-uses the loop device rather than
+initialize a new device if the same backing file is already initialized with the
+same offset and sizelimit.
+.TP
+.BR \-F , " \-\-force"
+Force to create conflicting loop device. If \fIloopdev\fP is specified,
+error is ignored and a conflicting loop device is created.
+
+If \fI--find\fP with argument is speficied together with \fI--force\fP, new
+loop device is always allocated instead of re-use of matching one.
+
+Note that overlaying loop devices can cause data loss, corruption and
+overwrites. Use with extreme care!
 .TP
 .BR \-j , " \-\-associated " \fIfile
 Show the status of all loop devices associated with the given
-- 
2.9.2


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
