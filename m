Return-Path: dave@gnu.org
Subject: [PATCH 3/3] fdisk: gpt: update manpage
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Aug 2012 14:03:26 +0200
Message-ID: <1345550606.2664.7.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.8 |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fdisks/fdisk.8 b/fdisks/fdisk.8
index 5233f0f..93280c1 100644
--- a/fdisks/fdisk.8
+++ b/fdisks/fdisk.8
@@ -36,11 +36,6 @@ partition tables.
 It understands DOS-type partition tables and BSD- or SUN-type disklabels.
 
 .B fdisk
-does not understand GUID partition tables (GPTs) and it is not designed
-for large partitions.  In these cases, use the more advanced GNU
-.BR parted (8).
-
-.B fdisk
 does not use DOS-compatible mode and cylinders as display units by default.
 The old deprecated DOS behavior can be enabled with
 the '-c=dos -u=cylinders' command-line options.
@@ -82,6 +77,18 @@ is the first partition on the first hard disk in the system.
 See also Linux kernel documentation (the Documentation/devices.txt file).
 
 .SH DISK LABELS
+A GPT-type disklabel can describe 128 partitions, eliminating the need for
+extended or logical partitions. These partitions are 64bit sector type and
+thus exceeds the standard 2TiB limit with 32bit types. These partition entries
+are located between LBA 2-33 (inclusively), noting that GPT is not aware of CHS
+addressing. Regarding the on-disk's master boot record format, fdisk can detect
+both protective and hybrid ones. For hybrid MBRs, the write operation will not
+be useful since doing so would create a valid protective MBR and therefore destroy
+current functionality, like booting.
+
+Note that GPT support is currently a new feature in fdisk, and 
+therefore in an experimental phase, use at your own risk.
+
 A BSD/SUN-type disklabel can describe 8 partitions,
 the third of which should be a `whole disk' partition.
 Do not start a partition that actually uses its first sector
-- 
1.7.4.1
