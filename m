Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:49422 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933807AbcCNJLE (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 05:11:04 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] docs: improve grammar and wording in the 2.28 release notes
Date: Mon, 14 Mar 2016 10:10:13 +0100
Message-Id: <1457946613-2435-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
References: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 Documentation/releases/v2.28-ReleaseNotes |   36 ++++++++++++++--------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/releases/v2.28-ReleaseNotes b/Documentation/releases/v2.28-ReleaseNotes
index 789b130..9518ae9 100644
--- a/Documentation/releases/v2.28-ReleaseNotes
+++ b/Documentation/releases/v2.28-ReleaseNotes
@@ -1,35 +1,35 @@
 Util-linux 2.28 Release Notes
 =============================
 
-Now cfdisk, sfdisk and fdisk wipe all filesystems and RAID signatures when
-create a new disk label in interactive mode. It's possible to control this
-feature by --wipe=<auto,never,always>. The feature is disabled by default for
-not-terminals.
+Now cfdisk, sfdisk and fdisk wipe all filesystem and RAID signatures when
+creating a new disk label in interactive mode.  It's possible to control this
+feature with --wipe[=auto|never|always].  For non-terminals the feature is
+disabled by default.
 
-lsns -- this NEW COMMAND lists information about all the currently accessible
-namespaces or about the given namespace. 
+lsns -- this NEW COMMAND lists information about all currently accessible
+namespaces or about the given namespace.
 
 The command sfdisk supports new operations --delete, --move-data and --reorder.
 
 The command blkdiscard supports a new option --zeroout to zero-fill rather than
-discard specified area.
+discard a specified area.
 
 The command cal supports a new option --span to span the date when displaying
 multiple months (e.g. "cal --span --months 5" to display two months before and
 two months after the current month).
 
-The command chrt supports DEADLINE scheduling class and new options
+The command chrt supports the DEADLINE scheduling class and the new options
 --sched-runtime --sched-period and --sched-deadline.
 
-The command logger supports RFC 5424 structured data by new options --sd-id and
---sd-param.
+The command logger supports RFC 5424 structured data through the new options
+--sd-id and --sd-param.
 
 The command losetup supports a new option --direct-io[=on|off].
 
-The command lsblk allows to sort output by non-printed columns (e.g. lsblk
+The command lsblk allows to sort output by unprinted columns (e.g. lsblk
 --output NAME --sort SIZE).
 
-The command mount applies nofail mount option to ENOMEDIUM errors.
+The command mount applies the nofail mount option to ENOMEDIUM errors.
 
 The library libmount has been improved to properly detect already mounted btrfs
 subvolumes.
@@ -47,13 +47,13 @@ anymore.
 Security issues
 ---------------
 
-CVE-2016-2779 
+CVE-2016-2779
 
-This security issue is NOT FIXED yet. The ioctl TIOCSTI is possible to disable
-by setsid() only. Unfortunately, setsid() has well define use-cases in su(1)
-and runuser(1) and possible changes will introduce regressions. It seems we
-need a better way -- ideally another ioctl (or whatever supported by kernel) to 
-disable TIOCSTI without setsid().
+This security issue is NOT FIXED yet.  It is possible to disable the ioctl
+TIOCSTI by setsid() only.  Unfortunately, setsid() has well-defined use cases
+in su(1) and runuser(1) and any changes would introduce regressions.  It seems
+we need a better way -- ideally another ioctl (or whatever is supported by the
+kernel) to disable TIOCSTI without setsid().
 
 
 Stable maintenance releases between v2.27 and v2.28
-- 
1.7.0.4

