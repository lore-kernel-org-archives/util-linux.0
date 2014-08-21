Return-Path: util-linux-owner@vger.kernel.org
Received: from nymeria.archlinux.org ([89.238.67.251]:41358 "EHLO
	nymeria.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbaHUQRG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Aug 2014 12:17:06 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] mountpoint.1: clarify that it works on files
Date: Thu, 21 Aug 2014 12:16:57 -0400
Message-Id: <1408637817-29781-1-git-send-email-dreisner@archlinux.org>
In-Reply-To: <y2aa96xc11t.fsf@cartman.at.offog.org>
References: <y2aa96xc11t.fsf@cartman.at.offog.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

fef4dfa174 removed the restriction that the argument must explicitly be
a directory, so let's fix up the documentation to reflect that.
---
 sys-utils/mountpoint.1 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mountpoint.1 b/sys-utils/mountpoint.1
index 29c153c..078ba25 100644
--- a/sys-utils/mountpoint.1
+++ b/sys-utils/mountpoint.1
@@ -1,11 +1,13 @@
 .\" -*- nroff -*-
 .TH MOUNTPOINT 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
-mountpoint \- see if a directory is a mountpoint
+mountpoint \- see if a directory or file is a mountpoint
 .SH SYNOPSIS
 .B mountpoint
 .RB [ \-d | \-q ]
 .I directory
+|
+.I file
 .sp
 .B mountpoint
 .B \-x
@@ -15,6 +17,8 @@ mountpoint \- see if a directory is a mountpoint
 .B mountpoint
 checks whether the given
 .I directory
+or
+.I file
 is mentioned in the /proc/self/mountinfo file.
 .SH OPTIONS
 .TP
@@ -34,7 +38,7 @@ Display version information and exit.
 .BR \-h , " \-\-help"
 Display help text and exit.
 .SH EXIT STATUS
-Zero if the directory is a mountpoint, non-zero if not.
+Zero if the directory or file is a mountpoint, non-zero if not.
 .SH AUTHOR
 .PP
 Karel Zak <kzak@redhat.com>
-- 
2.1.0
