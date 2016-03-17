Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:62063 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933165AbcCQJjy (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 05:39:54 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/5] script: tweak spacing and wording, and restore filling in the man page
Date: Thu, 17 Mar 2016 10:39:12 +0100
Message-Id: <1458207554-2405-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458207554-2405-1-git-send-email-bensberg@justemail.net>
References: <1458207554-2405-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 term-utils/script.1 |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/term-utils/script.1 b/term-utils/script.1
index d4f5c00..8735664 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -124,12 +124,13 @@ meant to emulate a hardcopy terminal.
 .PP
 It is not recommended to run
 .B script
-in non-interactive shells. The inner shell of
+in non-interactive shells.  The inner shell of
 .B script
-is always interactive, and this could lead to unexpected results. If you use
+is always interactive, and this could lead to unexpected results.  If you use
 .B script
 in the shell initialization file, you have to avoid entering an infinite
-loop. Use e. g. profile file, which is read by login shells only:
+loop.  You can use for example the \fB\%.profile\fR file, which is read
+by login shells only:
 .RS
 .RE
 .sp
@@ -142,6 +143,7 @@ if test -t 0 ; then
 fi
 .fi
 .RE
+.ad
 .PP
 You should also avoid use of script in command pipes, as
 .B script
@@ -178,11 +180,11 @@ in the log file, including linefeeds and backspaces.  This is not what the
 naive user expects.
 .PP
 .B script
-is primarily designed for interactive terminal sessions, it's possible that when stdin 
-is not a terminal (for example "echo foo | script") then all session hung ups, because
-interactive shell within script session miss EOF and the 
+is primarily designed for interactive terminal sessions.  When stdin
+is not a terminal (for example: \fBecho foo | script\fR), then the session
+can hang, because the interactive shell within the script session misses EOF and
 .B script
-has no clue when close the session. See the NOTES section for more information.
+has no clue when to close the session.  See the \fBNOTES\fR section for more information.
 .SH AVAILABILITY
 The script command is part of the util-linux package and is available from
 .UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
-- 
1.7.0.4

