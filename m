Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:49970 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2F1O0w (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 28 Jun 2012 10:26:52 -0400
Message-ID: <4FEC69A9.8080507@bernhard-voelker.de>
Date: Thu, 28 Jun 2012 16:26:49 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] findmnt: fix typo in manpage
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix new typos introduced in v2.21-781-gc7fcc83.

Have a nice day,
Berny


>From 00c09810c82391ad9c6ff796b2f24f7c9114ebb0 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Thu, 28 Jun 2012 16:24:56 +0200
Subject: [PATCH] findmnt: fix typo in manpage

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 misc-utils/findmnt.8 |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index f92bffd..2072c52 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -73,7 +73,7 @@ Convert all tags (LABEL, UUID, PARTUUID or PARTLABEL) to the device names.
 .IP "\fB\-F, \-\-tab\-file \fIpath\fP"
 Search in an alternative file, if used with \fB\-\-fstab\fP, \fB\-\-mtab\fP
 or \fB\-\-kernel\fP then overwrites the default paths, if specified more than
-once than tree-like output is disabled (see the \fB\-\-list\fP option).
+once, then tree-like output is disabled (see the \fB\-\-list\fP option).
 .IP "\fB\-f, \-\-first\-only\fP"
 Print the first matching filesystem only.
 .IP "\fB\-i, \-\-invert\fP"
@@ -87,8 +87,8 @@ source file (the option \fB\-F\fP) is specified.
 Do not print a [/dir] in the SOURCE column for bind-mounts or btrfs subvolumes.
 .IP "\fB\-N, \-\-task \fItid\fP"
 Use alternative namespace /proc/<tid>/mountinfo rather than the default
-/proc/self/mountinfo. If the option is specified more than once than tree-like
-output is disabled (see the \fB\-\-list\fP option). See also
+/proc/self/mountinfo. If the option is specified more than once, then
+tree-like output is disabled (see the \fB\-\-list\fP option). See also
 .BR unshare (1)
 command.
 .IP "\fB\-n, \-\-noheadings\fP"
-- 
1.7.7


