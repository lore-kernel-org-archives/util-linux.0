Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:56542 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab2DXIIo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Apr 2012 04:08:44 -0400
Message-ID: <4F965F89.80007@bernhard-voelker.de>
Date: Tue, 24 Apr 2012 10:08:41 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] Fix further typos found by misspellings
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Following yesterday's discussion of my previous patch:
  "[PATCH] Fix typos found by misspellings"
  http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/5651/focus=5672


On 04/23/2012 01:27 PM, Karel Zak wrote:
> On Fri, Apr 20, 2012 at 12:24:10AM +0200, Bernhard Voelker wrote:
>> ... following typos:
...
>> They are all in old changelogs - are these frozen or also to be changed?
> 
>  I think we can change it, frozen is FTP and git history, but not the
>  current source tree.

Here are the fixes for the remaining typos (apart from the 3 false positives
for variable names).

Have a nice day,
Berny


>From 1035fddb963ee25f199c9c1750b17ede3d2493a5 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Tue, 24 Apr 2012 09:57:30 +0200
Subject: [PATCH] Fix further typos found by misspellings

Additionally to the fixes in commit v2.21-325-g455fe9a,
fix typos in release notes and NEWS.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 Documentation/releases/v2.13-ReleaseNotes |    2 +-
 Documentation/releases/v2.19-ReleaseNotes |    4 ++--
 Documentation/releases/v2.20-ReleaseNotes |    2 +-
 Documentation/releases/v2.21-ReleaseNotes |    2 +-
 NEWS                                      |    4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/releases/v2.13-ReleaseNotes b/Documentation/releases/v2.13-ReleaseNotes
index efd5d68..e3dc9f7 100644
--- a/Documentation/releases/v2.13-ReleaseNotes
+++ b/Documentation/releases/v2.13-ReleaseNotes
@@ -192,7 +192,7 @@ fdisk:
 getopt:
    - remove old unused files  [Karel Zak]
 hexdump:
-   - don't use memset with zero lenght  [Karel Zak]
+   - don't use memset with zero length  [Karel Zak]
 hwclock:
    - add --rtc=<path> option and support for /dev/rtc0  [Karel Zak]
    - add support for audit system  [Karel Zak]
diff --git a/Documentation/releases/v2.19-ReleaseNotes b/Documentation/releases/v2.19-ReleaseNotes
index 4c6c1a0..c15d82c 100644
--- a/Documentation/releases/v2.19-ReleaseNotes
+++ b/Documentation/releases/v2.19-ReleaseNotes
@@ -318,12 +318,12 @@ libmount:
    - add mntent.h compatible stuff  [Karel Zak]
    - add mount(2) and /sbin/mount.<type> support  [Karel Zak]
    - add mount(8) sample  [Karel Zak]
-   - add mtab managment to context API  [Karel Zak]
+   - add mtab management to context API  [Karel Zak]
    - add new debug messages, fix umount return code  [Karel Zak]
    - add new psetudo filesystems  [Karel Zak]
    - add new pseudo filesystems  [Karel Zak]
    - add routines for uid=, git= and context= translation  [Karel Zak]
-   - add support for mtab managment  [Karel Zak]
+   - add support for mtab management  [Karel Zak]
    - add uhelper=, improve mnt_split_optstr()  [Karel Zak]
    - add umount(2) support  [Karel Zak]
    - add unit test for mnt_copy_fs()  [Karel Zak]
diff --git a/Documentation/releases/v2.20-ReleaseNotes b/Documentation/releases/v2.20-ReleaseNotes
index 4d0bd36..e020c3b 100644
--- a/Documentation/releases/v2.20-ReleaseNotes
+++ b/Documentation/releases/v2.20-ReleaseNotes
@@ -337,7 +337,7 @@ docs:
    - update TODO  [Sami Kerola]
    - update TODO file  [Karel Zak]
    - update TODO file  [Sami Kerola]
-   - update exmaple files  [Karel Zak]
+   - update example files  [Karel Zak]
    - update v2.20 ReleaseNotes  [Karel Zak]
    - uuidgen.1 mention long options  [Sami Kerola]
 elvtune, isosize:
diff --git a/Documentation/releases/v2.21-ReleaseNotes b/Documentation/releases/v2.21-ReleaseNotes
index 9f1ef2c..ea0b559 100644
--- a/Documentation/releases/v2.21-ReleaseNotes
+++ b/Documentation/releases/v2.21-ReleaseNotes
@@ -750,7 +750,7 @@ mkfs.cramfs:
    - close open file after usage [cppcheck]  [Sami Kerola]
 mkfs.minix:
    - Fix super_set_nzones()  [Maurizio Lombardi]
-   - In Minix V3 filesystems the maximum filename lenght is 60 chars and the dirsize is 64 bytes.  [Maurizio Lombardi]
+   - In Minix V3 filesystems the maximum filename length is 60 chars and the dirsize is 64 bytes.  [Maurizio Lombardi]
    - Some bug fixes  [Maurizio Lombardi]
    - The s_blocksize field of the MinixV3 superblock must be initialized with a valid block size, not the total number
of blocks of the device!  [Maurizio Lombardi]
    - The total number of zones is limited to 65536 only on V1 filesystems  [Maurizio Lombardi]
diff --git a/NEWS b/NEWS
index 5d3a7b3..c486f9e 100644
--- a/NEWS
+++ b/NEWS
@@ -207,7 +207,7 @@ util-linux 2.12n,o
 * lomount: revert patch from 2.12j
 * lptune.8: -T option is obsolete
 * mkswap, mkswap.8, swapon: support labels
-  (use HAVE_BLKID=no as long as the blkid library doesnt support this)
+  (use HAVE_BLKID=no as long as the blkid library doesn't support this)
 * umount: allow user unmounting repeatedly mounted nfs mounts

 util-linux 2.12m
@@ -1288,7 +1288,7 @@ Outstanding bugs:
 - login/getty has a denial of service problem.
 - Several places needs a bit more polish.
 - There are a _lot_ of nonfatal warnings when compiling mount.  This will
-  not necesarily be fixed.
+  not necessarily be fixed.


 util-linux 2.6
-- 
1.7.7

