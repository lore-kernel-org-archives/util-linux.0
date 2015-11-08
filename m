Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:63886 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750795AbbKHLIX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Nov 2015 06:08:23 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/6] lsipc: tweak a few wordings on the manpage
Date: Sun,  8 Nov 2015 11:54:15 +0100
Message-Id: <1446980055-2749-6-git-send-email-bensberg@justemail.net>
In-Reply-To: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
References: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/lsipc.1 |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/sys-utils/lsipc.1 b/sys-utils/lsipc.1
index 5ef714c..04852ea 100644
--- a/sys-utils/lsipc.1
+++ b/sys-utils/lsipc.1
@@ -1,6 +1,6 @@
 .\" Copyright 2015 Ondrej Oprala(ooprala@redhat.com)
 .\" May be distributed under the GNU General Public License
-.TH LSIPC "1" "June 2015" "util-linux" "User Commands"
+.TH LSIPC "1" "November 2015" "util-linux" "User Commands"
 .SH NAME
 lsipc \- show information on IPC facilities currently employed in the system
 .SH SYNOPSIS
@@ -19,11 +19,11 @@ This option needs to be combined with one of the three resource options:
 .BR \-m ,
 .BR \-q " or"
 .BR \-s .
-The default \fB\-\-id\fR output format is possible to override by
-the \fB\-\-list \-\-raw \-\-json\fR or \fB\-\-export\fR options.
+It is possible to override the default output format for this option with the
+\fB\-\-list\fR, \fB\-\-raw\fR, \fB\-\-json\fR or \fB\-\-export\fR option.
 .TP
 \fB\-g\fR, \fB\-\-global\fR
-Show system-wide usage and limits for a single IPC type.
+Show system-wide usage and limits of IPC resources.
 This option may be combined with one of the three resource options:
 .BR \-m ,
 .BR \-q " or"
@@ -45,7 +45,7 @@ Write information about active message queues.
 .TP
 \fB\-s\fR, \fB\-\-semaphores\fR
 Write information about active semaphore sets.
-.SS "Output formats"
+.SS "Output formatting"
 .TP
 \fB\-c\fR, \fB\-\-creator\fR
 Show creator and owner.
@@ -57,7 +57,8 @@ Output data in the format of NAME=VALUE.
 Use the JSON output format.
 .TP
 \fB\-l\fR, \fB\-\-list\fR
-Use the list output format. This is the default except for \fB\-\-id\fR.
+Use the list output format.  This is the default, except when \fB\-\-id\fR
+is used.
 .TP
 \fB\-n\fR, \fB\-\-newline\fR
 Display each piece of information on a separate line.
-- 
1.7.0.4

