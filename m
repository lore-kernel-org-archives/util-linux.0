Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:64062 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaEXLI2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 24 May 2014 07:08:28 -0400
Received: by mail-wi0-f171.google.com with SMTP id cc10so1994145wib.10
        for <util-linux@vger.kernel.org>; Sat, 24 May 2014 04:08:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/4] docs: setterm.1 add missing options to manual page and remove duplicate
Date: Sat, 24 May 2014 12:08:14 +0100
Message-Id: <1400929696-12548-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.1 | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index d15fd40..5b843dc 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -52,6 +52,9 @@ cause problems for vi users.
 Like \fB\-\-dump\fP, but appends to the snapshot file instead of overwriting
 it.  Only works if no \fB\-\-dump\fP options are given.
 .TP
+\fB\-\-foreground\fP \fI8-color\fP|\fBdefault\fP (virtual consoles only)
+Sets the foreground text color.
+.TP
 \fB\-\-background\fP \fI8-color\fP|\fBdefault\fP (virtual consoles only)
 Sets the background text color.
 .TP
@@ -106,16 +109,25 @@ specified in the \fB\-\-file\fP option, overwriting its contents; the default
 is screen.dump.  Without an argument, dumps the current virtual console.
 Overrides \fB\-\-append\fP.
 .TP
-.BR \-\-append " [\fI1-NR_CONS\fP]"
-Like \fB\-\-dump\fP, but appends to the snapshot file instead of overwriting
-it.  Only works if no \fB\-\-dump\fP options are given.
-.TP
 .BI \-\-file " dumpfilename"
 Sets the snapshot file name for any \fB\-\-dump\fP or \fB\-\-append\fP options
 on the same command line.  If this option is not present, the default is
 screen.dump in the current directory.  A path name that exceeds system
 maximum will be truncated, see PATH_MAX from linux/limits.h for the value.
 .TP
+\fB\-\-hbcolor\fP \fI16-color\fP (virtual consoles only)
+Sets the color for bold characters.
+.TP
+.B \-\-initialize
+Displays the terminal initialization string, which typically sets the
+terminal's rendering options, and other attributes to the default values.
+.TP
+.BR \-\-inversescreen " [" on | off "]"
+Invert foreground and background color.
+.TP
+.BR \-\-linewrap " [" on | off "]"
+Continue on a new line when a line is full.
+.TP
 .BR \-\-msg " [" on | off "] (virtual consoles only)"
 Enables or disables the sending of kernel \fBprintk()\fP messages to the
 console.
-- 
1.9.3

