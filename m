Return-Path: util-linux-owner@vger.kernel.org
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:54989 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaKOUlp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 15 Nov 2014 15:41:45 -0500
Received: from localhost.localdomain (85-76-7-159-nat.elisa-mobile.fi [85.76.7.159])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 68B7E699B2
	for <util-linux@vger.kernel.org>; Sat, 15 Nov 2014 22:41:43 +0200 (EET)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH] Spelling fixes
Date: Sat, 15 Nov 2014 22:41:43 +0200
Message-Id: <1416084103-15931-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 AUTHORS                                   | 2 +-
 Documentation/releases/v2.22-ReleaseNotes | 2 +-
 Documentation/releases/v2.24-ReleaseNotes | 4 ++--
 Documentation/releases/v2.25-ReleaseNotes | 2 +-
 misc-utils/logger.1                       | 2 +-
 sys-utils/mount.8                         | 2 +-
 tests/functions.sh                        | 2 +-
 tests/run.sh                              | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/AUTHORS b/AUTHORS
index 72a5d72..15e4ae2 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -1,5 +1,5 @@
 
-                            utils-linux
+                            util-linux
 
 MAINTAINER:
 
diff --git a/Documentation/releases/v2.22-ReleaseNotes b/Documentation/releases/v2.22-ReleaseNotes
index 5a58a3e..7b5dd81 100644
--- a/Documentation/releases/v2.22-ReleaseNotes
+++ b/Documentation/releases/v2.22-ReleaseNotes
@@ -26,7 +26,7 @@ dmesg(1):
 
 su(1):
   - has been merged from coreutils into util-linux
-  - utils-linux version uses /etc/pam.d/su-l PAM config file for --login 
+  - util-linux version uses /etc/pam.d/su-l PAM config file for --login 
     (e.g. "su -") session.
 
 sulogin(8):
diff --git a/Documentation/releases/v2.24-ReleaseNotes b/Documentation/releases/v2.24-ReleaseNotes
index 132a5e3..b1c7d28 100644
--- a/Documentation/releases/v2.24-ReleaseNotes
+++ b/Documentation/releases/v2.24-ReleaseNotes
@@ -190,7 +190,7 @@ chfn:
    - assigned value is never read [clang-analyzer]  [Sami Kerola]
 column:
    - dereference of null pointer [clang-analyzer]  [Sami Kerola]
-   - use variable lenght printf field width to wprint blanks  [Sami Kerola]
+   - use variable length printf field width to wprint blanks  [Sami Kerola]
 cytune:
    - fix glush typo in cytune  [Rafael Ferreira]
 dmesg:
@@ -692,7 +692,7 @@ more:
    - fix warning when compiled --without-ncurses  [Karel Zak]
    - guarantee space for multibyte  [Karel Zak]
    - make output redirection more efficient  [Sami Kerola]
-   - use variable lenght printf field width to print blanks  [Sami Kerola]
+   - use variable length printf field width to print blanks  [Sami Kerola]
 mount:
    - (deprecated) fix typo tailed->failed  [Yuri Chornoivan]
    - add notes about UUIDs to the man page  [Karel Zak]
diff --git a/Documentation/releases/v2.25-ReleaseNotes b/Documentation/releases/v2.25-ReleaseNotes
index f4faf7a..4cd1759 100644
--- a/Documentation/releases/v2.25-ReleaseNotes
+++ b/Documentation/releases/v2.25-ReleaseNotes
@@ -1146,7 +1146,7 @@ tests:
    - allow to add or override test suite options  [Ruediger Meier]
    - avoid executing dirname(1) command  [Sami Kerola]
    - cal  do not let --week=<num> to adjust requested month  [Sami Kerola]
-   - cal  take account week numbers when determing month lenght  [Sami Kerola]
+   - cal  take account week numbers when determing month length  [Sami Kerola]
    - cal(1) is year is limited to signed 32 bit value  [Sami Kerola]
    - call ts_init_env as early as possible  [Ruediger Meier]
    - check /proc availability, and go-around if it is incomplete  [Sami Kerola]
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index ac77e9f..3bfcb3d 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -124,7 +124,7 @@ Use RFC 3164 BSD syslog protocol to submit messages to remote server.
 Use RFC 5424 syslog protocol to submit messages to remote server.
 Optional argument
 .I notime
-will supress submission of sender time stamp that is in ISO-8601 format,
+will suppress submission of sender time stamp that is in ISO-8601 format,
 including microseconds and timezone.  When
 .I notime
 is specified the time quality structured data, that can be suppressed
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index ba0fe31..272fd7d 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -482,7 +482,7 @@ syscall, and the flags cannot be mixed with other mount options.
 Since util-linux 2.23 the \fBmount\fR command allows to use several propagation flags
 together and also together with other mount operations.  This feature is EXPERIMENTAL.
 The propagation flags are applied by additional \fBmount\fR(2) syscalls when the
-preceeding mount operations were successful.  Note that this use case is not
+preceding mount operations were successful.  Note that this use case is not
 atomic.  It is possible to specify the propagation flags in
 .BR fstab (5)
 as mount options
diff --git a/tests/functions.sh b/tests/functions.sh
index 59107b0..a9b3758 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -601,7 +601,7 @@ function ts_scsi_debug_init {
 	local devname
 	TS_DEVICE="none"
 
-	# dry run is not realy reliable, real modprobe may still fail
+	# dry run is not really reliable, real modprobe may still fail
 	modprobe --dry-run --quiet scsi_debug &>/dev/null \
 		|| ts_skip "missing scsi_debug module (dry-run)"
 
diff --git a/tests/run.sh b/tests/run.sh
index 1f2971a..f61b6e4 100755
--- a/tests/run.sh
+++ b/tests/run.sh
@@ -49,7 +49,7 @@ while [ -n "$1" ]; do
 		;;
 	--nonroot)
 		if [ $(id -ru) -eq 0 ]; then
-			echo "Ignore utils-linux test suite [non-root UID expected]."
+			echo "Ignore util-linux test suite [non-root UID expected]."
 			exit 0
 		fi
 		;;
-- 
1.9.3

