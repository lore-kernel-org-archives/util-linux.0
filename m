Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:47516 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbcEJT06 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 May 2016 15:26:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 720AA340B9B
	for <util-linux@vger.kernel.org>; Tue, 10 May 2016 19:26:56 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] man pages: fix spacing between man page name & section number
Date: Tue, 10 May 2016 15:26:54 -0400
Message-Id: <1462908414-11449-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Most have standardized correctly, but fix a few latent ones.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 disk-utils/cfdisk.8 | 2 +-
 disk-utils/sfdisk.8 | 4 ++--
 misc-utils/kill.1   | 2 +-
 misc-utils/logger.1 | 2 +-
 sys-utils/losetup.8 | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
index ff95aa9..68cec94 100644
--- a/disk-utils/cfdisk.8
+++ b/disk-utils/cfdisk.8
@@ -190,7 +190,7 @@ enables libsmartcols debug output.
 .BR sfdisk (8),
 .BR parted (8),
 .BR partprobe (8),
-.BR partx(8)
+.BR partx (8)
 .SH AUTHOR
 Karel Zak <kzak@redhat.com>
 .PP
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 79424c5..0c13a48 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -441,7 +441,7 @@ The GPT header can later be restored by:
 .RE
 Note that \fBsfdisk\fR since version 2.26 no longer provides the \fB\-I\fR option to
 restore sectors.
-.B dd (1)
+.BR dd (1)
 provides all necessary functionality.
 
 .SH COLORS
@@ -487,7 +487,7 @@ enables libsmartcols debug output.
 .BR cfdisk (8),
 .BR parted (8),
 .BR partprobe (8),
-.BR partx(8)
+.BR partx (8)
 
 .SH AUTHOR
 Karel Zak <kzak@redhat.com>
diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 2d8c883..d3dc20e 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -118,7 +118,7 @@ It is not possible to send a signal to an explicitly selected thread in a
 multithreaded process using the
 .BR kill (2)
 syscall.  If
-.BR kill(2)
+.BR kill (2)
 is used to send a signal to a thread group, then the kernel selects an arbitrary
 member of the thread group that has not blocked the signal.  For more details
 see
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 0417b93..2c58c15 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -75,7 +75,7 @@ command's PID.  The use of \fB\-\-id=$$\fR
 Note that the system logging infrastructure (for example \fBsystemd\fR when
 listening on /dev/log) may follow local socket credentials to overwrite the
 PID specified in the message.
-.BR logger(1)
+.BR logger (1)
 is able to set those socket credentials to the given \fIid\fR, but only if you
 have root permissions and a process with the specified PID exists, otherwise
 the socket credentials are not modified and the problem is silently ignored.
diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index dbc9095..b614416 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -151,7 +151,7 @@ Display help text and exit.
 
 .SH ENCRYPTION
 .B Cryptoloop is no longer supported in favor of dm-crypt.
-.B For more details see cryptsetup (8).
+.B For more details see cryptsetup(8).
 
 .SH RETURN VALUE
 .B losetup
-- 
2.7.4

