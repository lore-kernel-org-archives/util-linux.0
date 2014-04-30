Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:63499 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106AbaD3CGs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Apr 2014 22:06:48 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 7/7] lib/terminal-colors.d.5: Improve the typesetting of the manual
Date: Wed, 30 Apr 2014 02:05:00 +0000
Message-Id: <1398823500-19737-2-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1398823500-19737-1-git-send-email-bjarniig@rhi.hi.is>
References: <1398823500-19737-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Remove '\&' in front of a full stop (.), when it does not start or
end a string

  Adjust space between sentences to two space characters (or begin each
sentence on a new line).

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 lib/terminal-colors.d.5 | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/terminal-colors.d.5 b/lib/terminal-colors.d.5
index ea06f96..c5208cd 100644
--- a/lib/terminal-colors.d.5
+++ b/lib/terminal-colors.d.5
@@ -3,35 +3,35 @@
 .\" Copyright (C) 2014 Karel Zak <kzak@redhat.com>
 .\" Copyright 2014 Red Hat, Inc.
 .\" May be distributed under the GNU General Public License
-.TH "TERMINAL_COLORS\&.D" "5" "January 2014" "util-linux" "terminal-colors.d"
+.TH "TERMINAL_COLORS.D" "5" "January 2014" "util-linux" "terminal-colors.d"
 .SH "NAME"
 terminal-colors.d \- Configure output colorization for various utilities
 .SH "SYNOPSIS"
 .PP
-/etc/terminal-colors\&.d/[name\&.]disable
+/etc/terminal-colors.d/[name.]disable
 .sp
-/etc/terminal-colors\&.d/name\&.enable
+/etc/terminal-colors.d/name.enable
 .SH "DESCRIPTION"
 Files in this directory determine the default behaviour for utilities
-when coloring output. The
+when coloring output.  The
 .B name
-is an utility name. Supported files:
+is an utility name.  Supported files:
 
 .TP
 .B disable
 Turns off output colorization for all compatible utilities.
 .TP
-.B name\&.disable
+.B name.disable
 Turns off output colorization for specified utility.
 .TP
-.B name\&.enable
+.B name.enable
 Turns on output colorization on terminal for specified utility, all another
 .B disable
 files are ignored.
 
 .SH COMPATIBILITY
-The terminal-colors\&.d functionality is currently supported by all util-linux
-utilities which provides colorized output. For more details always see the
+The terminal-colors.d functionality is currently supported by all util-linux
+utilities which provides colorized output.  For more details always see the
 COLORS section in the man page for the utility.
 
 .SH AVAILABILITY
-- 
1.9.0

