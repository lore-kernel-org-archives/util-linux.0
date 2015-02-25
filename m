Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46248 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbbBYOIA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Feb 2015 09:08:00 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH v2] docs: fix some spelling errors and typos in man pages
Date: Wed, 25 Feb 2015 09:07:59 -0500
Message-Id: <1424873279-12250-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

runuser.1: fix spelling implemenation -> implementation
scriptreplay.1: fix spelling overide -> override
unshare.1: fix spelling permamently -> permanently
last.1: fix spelling preferrable -> preferable
lslogins.1: fix spelling priviliges -> privileges
hwclock.8.in: fix spelling transfered -> transferred
prlimit.1: fix typo umlimited -> unlimited
agetty.8: fix typo unnsupported -> unsupported

Signed-off-by: Bill Pemberton <wfp5p@worldbroken.com>
---
 login-utils/last.1        | 2 +-
 login-utils/lslogins.1    | 2 +-
 login-utils/runuser.1     | 2 +-
 sys-utils/hwclock.8.in    | 2 +-
 sys-utils/prlimit.1       | 2 +-
 sys-utils/unshare.1       | 2 +-
 term-utils/agetty.8       | 2 +-
 term-utils/scriptreplay.1 | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/login-utils/last.1 b/login-utils/last.1
index 23ebaf32e9ee..719a0ede9f2b 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -140,7 +140,7 @@ is the same as the
 option.  The
 .I iso
 variant will display the timestamp in ISO-8601 format.  The ISO format
-contains timezone information, making it preferrable when printouts are
+contains timezone information, making it preferable when printouts are
 investigated outside of the system.
 .TP
 .BR \-w , " \-\-fullnames"
diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index fd1c66157410..ad52936a48dd 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -20,7 +20,7 @@ Mandatory arguments to long options are mandatory for short options too.
 .TP
 \fB\-a\fR, \fB\-\-acc\-expiration\fR
 Display data about the date of last password change and the account expiration
-date (see \fBshadow\fR(5) for more info).  (Requires root priviliges.)
+date (see \fBshadow\fR(5) for more info).  (Requires root privileges.)
 .TP
 \fB\-\-btmp\-file \fIpath\fP
 Alternate path for btmp.
diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 1fec182c8f50..0672cd66d335 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -225,7 +225,7 @@ global logindef config file
 .BR su (1)
 .SH HISTORY
 This \fB runuser\fR command was
-derived from coreutils' \fBsu\fR, which was based on an implemenation by
+derived from coreutils' \fBsu\fR, which was based on an implementation by
 David MacKenzie, and the Fedora \fBrunuser\fR command by Dan Walsh.
 .SH AVAILABILITY
 The runuser command is part of the util-linux package and is
diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index b13be31a2cd9..fbc10caa34cc 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -854,7 +854,7 @@ running at their own speed and drifting away from the 'correct' time at
 their own rates.  The methods and software for drift correction are
 different for each of them.  However, most systems are configured to
 exchange values between these two clocks at startup and shutdown.  Now
-the individual device's time keeping errors are transfered back and
+the individual device's time keeping errors are transferred back and
 forth between each other.  Attempt to configure drift correction for only
 one of them, and the other's drift will be overlaid upon it.  If the big
 picture is not kept in mind, confusion will soon ensue.
diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index e5c2071569f4..600c706fcb32 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -99,7 +99,7 @@ of open files to 1024 and 4095, respectively.
 Modify only the soft limit for the number of processes.
 .IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
 Set for the current process both the soft and ceiling values for the number of
-processes to umlimited.
+processes to unlimited.
 .IP "\fBprlimit --cpu=10 sort -u hugefile\fP"
 Set both the soft and hard CPU time limit to ten seconds and run 'sort'.
 
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index f5975d1803b2..99a0d0ae49d7 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -96,7 +96,7 @@ until after GID map has been set. The GID map is writable by root when
 .BR setgroups(2)
 is enabled and GID map becomes writable by unprivileged processes when
 .BR setgroups(2)
-is permamently disabled.
+is permanently disabled.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 1652e0aef269..c4b7f13e2eb1 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -255,7 +255,7 @@ Run login with this priority.
 \-\-reload
 Ask all running agetty instances to reload and update their displayed prompts,
 if the user has not yet commenced logging in. After doing so the command will
-exit. This feature might be unnsupported on systems without Linux
+exit. This feature might be unsupported on systems without Linux
 .BR inotify (7).
 .TP
 \-\-version
diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index 8c9053aed80f..312573cf6fee 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -42,7 +42,7 @@ For example, a speed-up of 2 makes
 go twice as fast, and a speed-up of 0.1 makes it go ten times slower
 than the original session.
 .SH OPTIONS
-The first three options will overide old-style arguments.
+The first three options will override old-style arguments.
 .TP
 .BR \-t , " \-\-timing " \fIfile\fR
 File containing \fBscript\fR's timing output.
-- 
2.1.0

