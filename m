Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:54809 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751240AbbAOTJM (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 15 Jan 2015 14:09:12 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] docs: fix grammar and punctuation of 2.26 release notes
Date: Thu, 15 Jan 2015 20:09:05 +0100
Message-Id: <1421348945-2329-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also trim some trailing whitespace.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 Documentation/releases/v2.26-ReleaseNotes |   70 ++++++++++++++--------------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/releases/v2.26-ReleaseNotes b/Documentation/releases/v2.26-ReleaseNotes
index b7712f7..68b09dd 100644
--- a/Documentation/releases/v2.26-ReleaseNotes
+++ b/Documentation/releases/v2.26-ReleaseNotes
@@ -1,29 +1,29 @@
 Util-linux 2.26 Release Notes
 =============================
 
- This version provides completely new sfdisk(8) command, the new version is
- based on libfdisk. If your use-cases depend on sfdisk(8) then it is strongly
+ This version provides a completely new sfdisk(8) command; the new version is
+ based on libfdisk. If your use cases depend on sfdisk(8) then it is strongly
  recommended to be careful and re-test your scripts. The new version supports
- MBR and GPT disk labels (SGI and SUN are also supported but no well tested).
- The new version does no more support some obscure MBR specific command line
+ MBR and GPT disk labels (SGI and SUN are also supported but not well tested).
+ The new version no longer supports some obscure MBR-specific command-line
  options and legacy CHS addressing.
 
 
- The library libblkid (and blkid(8) on command line) now uses the same UDF
- fields like Windows and another operations systems to get human readable
- UDF volume identifiers (LABEL= tag). This change maybe backwardly incompatible 
+ The library libblkid (and blkid(8) on the command line) now uses the same UDF
+ fields as Windows and other operating systems in order to get human-readable
+ UDF volume identifiers (LABEL= tag). This change may be backwardly incompatible
  for some UDF volumes.
 
 
  The command hwclock(8) uses the drift correction for all relevant operations
- and it is unnecessary to specify --adjuts on hwclock command line now.
+ and it is unnecessary to specify --adjust on the hwclock command line now.
 
- The command hwclock(8) does not automatically (re)calculate drift factor on
- --systohc to avoid several problem (ntpd with an '11 minute mode', etc.), but
- new command line option --update-drift has to be explicitly used to force
- hwclock(8) to update /etc/adjtime. 
+ The command hwclock(8) does not automatically (re)calculate the drift factor on
+ --systohc to avoid several problems (ntpd with '11 minute mode', for example),
+ but the new command-line option --update-drift has to be explicitly used to
+ force hwclock(8) to update /etc/adjtime.
 
- For more details see hwclock(8) man page.
+ For more details see the hwclock(8) man page.
 
 
 Release highlights
@@ -34,55 +34,55 @@ zramctl(8):
 
 agetty(8):
  - supports new options --reload to force already running agetty processes to
-   reprint /etc/issue file. 
+   reprint the /etc/issue file
 
 cfdisk(8), sfdisk(8) and fdisk(8):
- - supports sfdisk compatible scripts, it's possible to save your partitioning 
-   layout to text files and (re)use it in all fdisks.
+ - supports sfdisk compatible scripts; it's possible to save your partitioning
+   layout to text files and (re)use it in all fdisks
 
 fdisk(8), sfdisk(8):
- - support new command line option "--output <list>" to specify output columns
-   for --list or print commands.
+ - support new command-line option "--output <list>" to specify output columns
+   for --list or print commands
 
 nsenter(1):
  - has been updated to work with the latest kernel changes in user namespaces
- - supports new command line option --preserve-credentials
+ - supports new command-line option --preserve-credentials
 
 unshare(1):
  - has been updated to work with the latest kernel changes in user namespaces
- - suuports new command line option "--setgroups=<deny|allow>"
+ - supports new command-line option "--setgroups=<deny|allow>"
 
 swapon(8):
- - supports new command line option "-o <list>" with the same semantic like
-   -o for mount(8); now it's possible to specify swap options on command line
-   by the same string like in fstab 
+ - supports new command-line option "-o <list>" with the same semantic as
+   -o for mount(8); it's now possible to specify swap options on the command
+   line by the same string as in fstab
 
 fdformat(8):
- - supports new command line options --from/to to specify tracks and --repear
-   for broken floppies.
+ - supports new command-line options --from and --to to specify tracks and
+   --repair for broken floppies
 
 getopt(1):
- - has been updated to the latest version (originally maintained out of
-   util-linux) and refactored.
+ - has been updated to the latest version (originally maintained outside of
+   util-linux) and refactored
 
 ldattach(8):
- - has been improved to support GSM0710 and intro modem commands 
+ - has been improved to support GSM0710 and intro modem commands
 
 logger(1):
- - supports new command line option --id= to specify PID (or another ID)
+ - supports new command-line option --id= to specify PID (or another ID)
  - allows to specify --rfc3164 or --rfc5424 syslog protocols
 
 libfdisk:
- - the library is distributed as shared library with stable API and standard
-   header file.
+ - the library is distributed as a shared library with a stable API and a
+   standard header file
 
 libmount:
- - provides new simple API to monitor mount table changes (including
-   changes in userspace mount options).
+ - provides a new simple API to monitor mount-table changes (including
+   changes in userspace mount options)
 
 
-The debug infrastructure in libraries libmount, libsmartcolsm, libfdisk and
-libblkid allows to specify debug options by human readable strings too. For
+The debug infrastructure in the libraries libmount, libsmartcolsm, libfdisk and
+libblkid allows to specify debug options by human-readable strings too. For
 example "LIBMOUNT_DEBUG=all mount /mnt".
 
 
-- 
1.7.0.4

