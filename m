Return-Path: mail@bernhard-voelker.de
Message-ID: <5017EDFC.907@bernhard-voelker.de>
Date: Tue, 31 Jul 2012 16:38:52 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: tests: blkid/md-raid1-part fails
References: <501772B7.2040504@bernhard-voelker.de> <20120731135124.GB17896@x2.net.home>
In-Reply-To: <20120731135124.GB17896@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>



On 07/31/2012 03:51 PM, Karel Zak wrote:
> On Tue, Jul 31, 2012 at 07:52:55AM +0200, Bernhard Voelker wrote:
>> What's wrong with that minor number?
> 
> Nothing, it would be better to check if the line ID_PART_ENTRY_DISK=
> is in the $TS_OUTPUT and if yes then remove the line from the output
> file (e.g. by sed).
> 
> The tests should not rely on device numbers and device names -- on
> another places you can found /dev/loop0 in the expected outputs...
> 
> Patches wanted :-)
> 
>     Karel

Here it comes ;-)

Have a nice day,
Berny

>From bc2628ebe22174fb2f459e6229d846eb4b776380 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Tue, 31 Jul 2012 16:36:35 +0200
Subject: [PATCH] tests: make blkid/md-raid1-part more robust

* tests/expected/blkid/mk-raid1-part: Replace major and minor number
of ID_PART_ENTRY_DISK by a special string. Add ID_FS_UUID and
ID_FS_UUID_ENC again, also with a special string.
* tests/ts/blkid/md-raid1-part: Before comparing the expected output
with the actual output, replace the values of ID_PART_ENTRY_DISK,
ID_FS_UUID and ID_FS_UUID_ENC with the speacial strings mentioned above.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 tests/expected/blkid/md-raid1-part |   12 ++++++------
 tests/ts/blkid/md-raid1-part       |   10 ++++++----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tests/expected/blkid/md-raid1-part b/tests/expected/blkid/md-raid1-part
index d1e9cc9..ce93b73 100644
--- a/tests/expected/blkid/md-raid1-part
+++ b/tests/expected/blkid/md-raid1-part
@@ -41,10 +41,10 @@ ID_PART_TABLE_TYPE=dos
 Probe first RAID member
 ID_FS_TYPE=linux_raid_member
 ID_FS_USAGE=raid
-
-
+ID_FS_UUID=__ts_uuid__
+ID_FS_UUID_ENC=__ts_uuid_enc__
 ID_FS_VERSION=0.90.0
-ID_PART_ENTRY_DISK=8:16
+ID_PART_ENTRY_DISK=__ts_majorminor__
 ID_PART_ENTRY_NUMBER=1
 ID_PART_ENTRY_OFFSET=2048
 ID_PART_ENTRY_SCHEME=dos
@@ -53,10 +53,10 @@ ID_PART_ENTRY_TYPE=0x83
 Probe second RAID member
 ID_FS_TYPE=linux_raid_member
 ID_FS_USAGE=raid
-
-
+ID_FS_UUID=__ts_uuid__
+ID_FS_UUID_ENC=__ts_uuid_enc__
 ID_FS_VERSION=0.90.0
-ID_PART_ENTRY_DISK=8:16
+ID_PART_ENTRY_DISK=__ts_majorminor__
 ID_PART_ENTRY_NUMBER=2
 ID_PART_ENTRY_OFFSET=53248
 ID_PART_ENTRY_SCHEME=dos
diff --git a/tests/ts/blkid/md-raid1-part b/tests/ts/blkid/md-raid1-part
index 634c9a1..e13901d 100755
--- a/tests/ts/blkid/md-raid1-part
+++ b/tests/ts/blkid/md-raid1-part
@@ -59,8 +59,6 @@ sleep 3
 MD_DEVNAME=md8
 MD_DEVICE=/dev/${MD_DEVNAME}

-###exit 1
-
 ts_log "Create RAID1 device"
 /sbin/mdadm -q -S ${MD_DEVICE} &> /dev/null
 /sbin/mdadm -q --create ${MD_DEVICE} --metadata=0.90 --chunk=64 --level=1 \
@@ -83,7 +81,11 @@ sleep 3
 rmmod scsi_debug

 ts_fdisk_clean
-# remove generated UUIDs
-sed -i -e 's/ID_FS_UUID.*//g' $TS_OUTPUT
+# substitue UUIDs and major/minor number before comparison
+sed -i \
+  -e         's/^\(ID_FS_UUID\)=.*/\1=__ts_uuid__/' \
+  -e     's/^\(ID_FS_UUID_ENC\)=.*/\1=__ts_uuid_enc__/' \
+  -e 's/^\(ID_PART_ENTRY_DISK\)=.*/\1=__ts_majorminor__/' \
+  $TS_OUTPUT

 ts_finalize
-- 
1.7.7
