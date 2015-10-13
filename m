Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37351 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbJML3a (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Oct 2015 07:29:30 -0400
Received: by wijq8 with SMTP id q8so27291446wij.0
        for <util-linux@vger.kernel.org>; Tue, 13 Oct 2015 04:29:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 7/8] docs: update ctrlaltdel.8 man page
Date: Tue, 13 Oct 2015 12:29:13 +0100
Message-Id: <1444735754-18976-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
References: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Most significant clarification is to tell hard C_A_D is the default in linux
kernel.  Update also kernel reference, and improve readability.

Reference: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/kernel/reboot.c
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ctrlaltdel.8 | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sys-utils/ctrlaltdel.8 b/sys-utils/ctrlaltdel.8
index 30bbae4..4be6513 100644
--- a/sys-utils/ctrlaltdel.8
+++ b/sys-utils/ctrlaltdel.8
@@ -1,21 +1,23 @@
 .\" Copyright 1992, 1993 Rickard E. Faith (faith@cs.unc.edu)
 .\" May be distributed under the GNU General Public License
-.TH CTRLALTDEL 8 "August 2011" "util-linux" "System Administration"
+.TH CTRLALTDEL 8 "October 2015" "util-linux" "System Administration"
 .SH NAME
 ctrlaltdel \- set the function of the Ctrl-Alt-Del combination
 .SH SYNOPSIS
 .BR "ctrlaltdel hard" | soft
 .SH DESCRIPTION
 Based on examination of the
-.I linux/kernel/sys.c
+.I linux/kernel/reboot.c
 code, it is clear that there are two supported functions that the
-Ctrl-Alt-Del sequence can perform: a
-.I hard
-reset, which immediately reboots the computer without calling
+Ctrl-Alt-Del sequence can perform.
+.TP
+.B hard
+Immediately reboot the computer without calling
 .BR sync (2)
-and without any other preparation; and a
-.I soft
-reset, which sends the SIGINT (interrupt) signal to the
+and without any other preparation.  This is the default.
+.TP
+.B soft
+Will make kernel to send the SIGINT (interrupt) signal to the
 .B init
 process (this is always the process with PID 1).  If this option is used,
 the
@@ -39,7 +41,8 @@ Display help text and exit.
 .SH FILES
 .I /etc/rc.local
 .SH "SEE ALSO"
-.BR init (8)
+.BR init (8),
+.BR systemd (1)
 .SH AUTHOR
 .UR poe@daimi.aau.dk
 Peter Orbaek
-- 
2.6.1

