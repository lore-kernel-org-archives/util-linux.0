Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35220 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3FPSyR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:17 -0400
Received: by mail-wg0-f52.google.com with SMTP id b12so1800328wgh.7
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/15] docs: correct sfdisk --activate instructions
Date: Sun, 16 Jun 2013 19:53:46 +0100
Message-Id: <1371408836-16663-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The activate can be enabled by renaming the command to 'activate'.  Quite
confusingly the option and command arguments are interchangeable, and
depending on which one is defined as --activate option argument the
command will behave different rather different ways.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.8 | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fdisks/sfdisk.8 b/fdisks/sfdisk.8
index 57c9a68..2b166fa 100644
--- a/fdisks/sfdisk.8
+++ b/fdisks/sfdisk.8
@@ -223,8 +223,37 @@ and change nothing else. (Probably this fifth partition
 is called /dev/hdb5, but you are free to call it something else,
 like `/my_equipment/disks/2/5' or so).
 .TP
-.BR \-A ", " \-\-activate " \fInumber\fR"
-Make the indicated partition(s) active, and all others inactive.
+\fB\-A\fR, \fB\-\-activate\fR [\fIdevice\fR or \fIpartition number\fR]
+The activate option will turn on bootable flag.
+.IP
+The activate option takes optional argument.  When the option argument is
+not defined command will list partitions that has bootable flag set on
+for device given as command argument.  For example.
+.IP
+.nf
+.if t .ft CW
+    % sfdisk --activate /dev/sda
+.fi
+When the activate has option argument, and command argument list, the
+partitions defined as command argument will be set to have bootable flag.
+Other partitions for the device are clered not to have bootable flag.
+For example the partitions 1 and 4 are set bootable, while 2 and 3 are
+cleared.
+.IP
+.nf
+.if t .ft CW
+    % sfdisk --activate=/dev/sda 1 4
+.fi
+If only a single partition must be activated then the partition number
+must be given as option argument, and device as command argument.  For example.
+.IP
+.nf
+.if t .ft CW
+    % sfdisk --activate=1 /dev/sda
+.fi
+.IP
+The activate functionality is turned on when the program invocation name is
+.IR activate .
 .TP
 .BR \-c ", " \-\-id " \fInumber\fR [\fIId\fR]"
 If no \fIId\fR argument given: print the partition Id of the indicated
-- 
1.8.3.1

