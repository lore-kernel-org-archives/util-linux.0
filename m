Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:51958 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751066AbbHAIYX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 1 Aug 2015 04:24:23 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/7] docs: fix some grammar and punctuation in the 2.27 release notes
Date: Sat,  1 Aug 2015 10:23:10 +0200
Message-Id: <1438417391-2269-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1438417391-2269-1-git-send-email-bensberg@justemail.net>
References: <1438417391-2269-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 Documentation/releases/v2.27-ReleaseNotes |   52 ++++++++++++++--------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/releases/v2.27-ReleaseNotes b/Documentation/releases/v2.27-ReleaseNotes
index 83c97a3..21de111 100644
--- a/Documentation/releases/v2.27-ReleaseNotes
+++ b/Documentation/releases/v2.27-ReleaseNotes
@@ -3,51 +3,51 @@ Util-linux 2.27 Release Notes
 
 The command tailf is deprecated in favour of tail -f from coreutils.
 
-The command unshare provides a new option --propagation=<slave|shared|private|unchanged> 
+The command unshare provides a new option --propagation=slave|shared|private|unchanged
 to control propagation in mount namespaces. The default is "private" now. The
-new default unifies unshare behavior and makes it independent on distribution
-default. The unshare supports persistent namespaces too (no process has to run 
+new default unifies unshare behavior and makes it independent of distribution
+default. The unshare supports persistent namespaces too (no process has to run
 to keep namespace in existence).
 
-The fdisk and sfdisk is possible to compile with GNU Readline support to
-improve line-editing functionality.
+The commands fdisk and sfdisk can be compiled with GNU readline support to
+improve their line-editing functionality.
 
-The library libsmartcols and commands findmnt, losetup, lsblk, lslocks, sfdisk
-and lsipc provides output in JSON format.
+The library libsmartcols and the commands findmnt, losetup, lsblk, lslocks,
+sfdisk and lsipc provide output in JSON format.
 
-The command mkfs (deprecated in favour of mkfs.<type>) does not use hard coded
+The command mkfs (deprecated in favour of mkfs.<type>) does not use hard-coded
 paths, but it follows $PATH.
 
 The command script has been massively improved to be more robust and less
-complex.  Now all is implemented by one process which monitor the running
-session by poll(), signalfd() etc.
+complex.  Now all is implemented by one process which monitors the running
+session by poll(), signalfd(), etc.
 
-The command sulogin supports locked root accounts if the command line option
+The command sulogin supports locked root accounts if the command-line option
 --force is specified. Read the sulogin man page before you use it!
 
-The command agetty reloads prompt on addresses change if network information
-displayed.
+The command agetty reloads the prompt on address changes if network information
+is displayed.
 
-The util-linux supports and enable colors by default, this behavior is possible
-to change by --disable-colors-default to be more user friendly to color blind
-people. The colors is still possible to enable by /etc/terminal-colors.d. See
+util-linux now supports and enables colors by default. It is possible to change
+this behavior with --disable-colors-default to be more user-friendly to colorblind
+people. The colors can still be enabled by editing /etc/terminal-colors.d. See
 terminal-colors.d(5).
 
-The command cfdisk displays more information about selected partition
+The command cfdisk displays more information about the selected partition
 (partition UUID, filesystem identifiers, mountpoint, etc.). This extra window
-is possible to toggle by 'x' key.
+can be toggled with the 'x' key.
 
-The fdisk provides a new command 'F' to print free unpartitioned space (gaps)
-on the disk. The same functionality provides sfdisk by --list-free.  The fdisk
-wipes the begin of the device by default, the new option --protect-boot
-disables this behavior. The new fdisk command 'i' provides more information
-about a specified partition.
+The command fdisk provides a new command 'F' to print free, unpartitioned space
+(gaps) on the disk. The same functionality is provided by sfdisk through the
+option --list-free.  The fdisk command wipes the beginning of the device by
+default; the new option --protect-boot disables this behavior. The new fdisk
+command 'i' provides more information about a specified partition.
 
-The command cal supports new options --twelve and --months <n> to display next
-twelve or <n> months.
+The command cal supports the new options --twelve and --months <n> to display
+the next twelve or <n> months.
 
 The command rtcwake supports a new option --list-modes to list available modes,
-and a new option --date for human readable times. rtcwake does not support
+and a new option --date for human-readable times. rtcwake does not support
 RTC_ALM_READ and RTC_ALM_SET fallbacks any more.
 
 
-- 
1.7.0.4

