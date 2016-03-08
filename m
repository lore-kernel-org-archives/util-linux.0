Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:64682 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932400AbcCHJVz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 04:21:55 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/9] losetup: correct some formatting in the man page
Date: Tue,  8 Mar 2016 10:07:49 +0100
Message-Id: <1457428072-2619-6-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
References: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/losetup.8 |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index 90fcb9d..dbc9095 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -1,4 +1,4 @@
-.TH LOSETUP 8 "July 2014" "util-linux" "System Administration"
+.TH LOSETUP 8 "November 2015" "util-linux" "System Administration"
 .SH NAME
 losetup \- set up and control loop devices
 .SH SYNOPSIS
@@ -91,20 +91,22 @@ Detach the file or device associated with the specified loop device(s).
 .BR \-D , " \-\-detach\-all"
 Detach all associated loop devices.
 .TP
-.BR "\-\-direct\-io"[\fI=on|off\fR]
-Enable or disable direct I/O for the backing file. The optional argument can be
-\fIon\fR or \fIoff\fR.  If the optional argument is omitted, it defaults to \fIon\fR.
+.BR \-\-direct\-io [ =on | off ]
+Enable or disable direct I/O for the backing file.  The optional argument
+can be either \fBon\fR or \fBoff\fR.  If the argument is omitted, it defaults
+to \fBon\fR.
 .TP
 .BR \-f , " \-\-find"
 Find the first unused loop device.  If a
 .I file
 argument is present, use the found device as loop device.
 Otherwise, just print its name.
-.IP "\fB\-j, \-\-associated \fIfile\fP"
+.TP
+.BR \-j , " \-\-associated " \fIfile
 Show the status of all loop devices associated with the given
 .IR file .
 .TP
-.IP "\fB\-J, \fB\-\-json\fP"
+.BR \-J , " \-\-json"
 Use JSON format for \fB\-\-list\fP output.
 .TP
 .BR \-l , " \-\-list"
-- 
1.7.0.4

