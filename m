Return-Path: hare@suse.de
From: Hannes Reinecke <hare@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: Werner Fink <werner@suse.de>, Stanislav Brabec <sbrabec@suse.com>,
        <util-linux@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/2] Abort blkid on I/O errors
Date: Wed, 19 Mar 2014 14:50:54 +0100
Message-Id: <1395237056-26595-1-git-send-email-hare@suse.de>
List-ID: <util-linux.vger.kernel.org>

Whenever blkid incurs an I/O error it should abort all probes,
as any result will be bogus anyway. Plus blkid will taking
ages to complete on faulty devices, stalling the uevent queue
and resulting in udev killing the process eventually.

With this patch the number of I/O errors during
blkid run is cut from 156 to just 2.

Changes to v1:
- Fixup issues found when running 'make check'
- Only fail for I/O errors

Hannes Reinecke (2):
  blkid: stop scanning on I/O error
  blkid: convert superblocks to new calling convention

 libblkid/src/partitions/aix.c                |  2 +-
 libblkid/src/partitions/bsd.c                | 14 ++++++---
 libblkid/src/partitions/dos.c                | 24 ++++++++++-----
 libblkid/src/partitions/gpt.c                | 26 +++++++++++-----
 libblkid/src/partitions/mac.c                | 19 ++++++++----
 libblkid/src/partitions/minix.c              | 14 ++++++---
 libblkid/src/partitions/partitions.c         | 13 +++++---
 libblkid/src/partitions/sgi.c                | 12 +++++---
 libblkid/src/partitions/solaris_x86.c        | 14 ++++++---
 libblkid/src/partitions/sun.c                | 14 ++++++---
 libblkid/src/partitions/ultrix.c             | 16 ++++++----
 libblkid/src/partitions/unixware.c           | 14 ++++++---
 libblkid/src/probe.c                         | 13 ++++++--
 libblkid/src/superblocks/adaptec_raid.c      | 15 ++++-----
 libblkid/src/superblocks/bcache.c            |  4 +--
 libblkid/src/superblocks/befs.c              | 24 +++++++--------
 libblkid/src/superblocks/btrfs.c             |  2 +-
 libblkid/src/superblocks/cramfs.c            |  2 +-
 libblkid/src/superblocks/ddf_raid.c          | 19 +++++++-----
 libblkid/src/superblocks/drbd.c              |  8 ++---
 libblkid/src/superblocks/drbdproxy_datalog.c |  2 +-
 libblkid/src/superblocks/exfat.c             |  4 ++-
 libblkid/src/superblocks/ext.c               | 30 +++++++++---------
 libblkid/src/superblocks/f2fs.c              |  2 +-
 libblkid/src/superblocks/gfs.c               |  8 ++---
 libblkid/src/superblocks/hfs.c               | 12 ++++----
 libblkid/src/superblocks/highpoint_raid.c    | 12 ++++----
 libblkid/src/superblocks/hpfs.c              |  8 ++---
 libblkid/src/superblocks/iso9660.c           |  4 +--
 libblkid/src/superblocks/isw_raid.c          | 13 ++++----
 libblkid/src/superblocks/jfs.c               |  2 +-
 libblkid/src/superblocks/jmicron_raid.c      | 13 ++++----
 libblkid/src/superblocks/linux_raid.c        | 46 ++++++++++++++++------------
 libblkid/src/superblocks/lsi_raid.c          | 10 +++---
 libblkid/src/superblocks/luks.c              |  2 +-
 libblkid/src/superblocks/lvm.c               |  6 ++--
 libblkid/src/superblocks/minix.c             | 18 ++++++-----
 libblkid/src/superblocks/netware.c           |  2 +-
 libblkid/src/superblocks/nilfs.c             |  4 +--
 libblkid/src/superblocks/ntfs.c              |  6 ++--
 libblkid/src/superblocks/nvidia_raid.c       | 12 ++++----
 libblkid/src/superblocks/ocfs.c              |  8 ++---
 libblkid/src/superblocks/promise_raid.c      | 10 +++---
 libblkid/src/superblocks/reiserfs.c          |  8 ++---
 libblkid/src/superblocks/romfs.c             |  2 +-
 libblkid/src/superblocks/silicon_raid.c      | 10 +++---
 libblkid/src/superblocks/squashfs.c          |  2 +-
 libblkid/src/superblocks/superblocks.c       | 13 ++++++--
 libblkid/src/superblocks/swap.c              | 24 +++++++--------
 libblkid/src/superblocks/sysv.c              |  8 ++---
 libblkid/src/superblocks/ubifs.c             |  2 +-
 libblkid/src/superblocks/udf.c               | 16 +++++-----
 libblkid/src/superblocks/ufs.c               |  4 +--
 libblkid/src/superblocks/vfat.c              | 16 +++++-----
 libblkid/src/superblocks/via_raid.c          |  6 ++--
 libblkid/src/superblocks/vmfs.c              |  4 +--
 libblkid/src/superblocks/vxfs.c              |  2 +-
 libblkid/src/superblocks/xfs.c               |  6 ++--
 libblkid/src/superblocks/zfs.c               |  6 ++--
 59 files changed, 363 insertions(+), 269 deletions(-)

-- 
1.7.12.4
