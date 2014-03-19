Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56593 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933518AbaCSK7P (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Mar 2014 06:59:15 -0400
From: Hannes Reinecke <hare@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: Werner Fink <werner@suse.de>, Stanislav Brabec <sbrabec@suse.com>,
        <util-linux@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] Abort blkid on I/O errors
Date: Wed, 19 Mar 2014 11:59:07 +0100
Message-Id: <1395226749-5860-1-git-send-email-hare@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Whenever blkid incurs an I/O error it should abort all probes,
as any result will be bogus anyway. Plus blkid will taking
ages to complete on faulty devices, stalling the uevent queue
and resulting in udev killing the process eventually.

This patch cuts down the number of I/O errors during
blkid run from 156 to just 2.

Hannes Reinecke (2):
  blkid: stop scanning on I/O error
  blkid: convert superblocks to new calling convention

 libblkid/src/partitions/aix.c                |  2 +-
 libblkid/src/partitions/bsd.c                |  8 +++--
 libblkid/src/partitions/dos.c                |  8 +++--
 libblkid/src/partitions/gpt.c                | 18 ++++++++---
 libblkid/src/partitions/mac.c                | 13 ++++++--
 libblkid/src/partitions/minix.c              |  8 +++--
 libblkid/src/partitions/partitions.c         | 13 +++++---
 libblkid/src/partitions/sgi.c                |  8 +++--
 libblkid/src/partitions/sun.c                |  8 +++--
 libblkid/src/partitions/ultrix.c             |  8 +++--
 libblkid/src/partitions/unixware.c           |  8 +++--
 libblkid/src/probe.c                         | 13 ++++++--
 libblkid/src/superblocks/adaptec_raid.c      | 11 ++++---
 libblkid/src/superblocks/bcache.c            |  2 +-
 libblkid/src/superblocks/befs.c              | 20 ++++++------
 libblkid/src/superblocks/btrfs.c             |  2 +-
 libblkid/src/superblocks/cramfs.c            |  2 +-
 libblkid/src/superblocks/ddf_raid.c          | 19 +++++++-----
 libblkid/src/superblocks/drbd.c              |  6 ++--
 libblkid/src/superblocks/drbdproxy_datalog.c |  2 +-
 libblkid/src/superblocks/exfat.c             |  4 ++-
 libblkid/src/superblocks/ext.c               | 30 +++++++++---------
 libblkid/src/superblocks/f2fs.c              |  2 +-
 libblkid/src/superblocks/gfs.c               |  8 ++---
 libblkid/src/superblocks/hfs.c               | 12 ++++----
 libblkid/src/superblocks/highpoint_raid.c    | 10 +++---
 libblkid/src/superblocks/hpfs.c              |  8 ++---
 libblkid/src/superblocks/iso9660.c           |  4 +--
 libblkid/src/superblocks/isw_raid.c          | 11 ++++---
 libblkid/src/superblocks/jfs.c               |  2 +-
 libblkid/src/superblocks/jmicron_raid.c      |  9 +++---
 libblkid/src/superblocks/linux_raid.c        | 46 ++++++++++++++++------------
 libblkid/src/superblocks/lsi_raid.c          |  8 ++---
 libblkid/src/superblocks/luks.c              |  2 +-
 libblkid/src/superblocks/lvm.c               |  6 ++--
 libblkid/src/superblocks/minix.c             | 18 ++++++-----
 libblkid/src/superblocks/netware.c           |  2 +-
 libblkid/src/superblocks/ntfs.c              |  6 ++--
 libblkid/src/superblocks/nvidia_raid.c       |  8 ++---
 libblkid/src/superblocks/ocfs.c              |  8 ++---
 libblkid/src/superblocks/promise_raid.c      |  8 ++---
 libblkid/src/superblocks/reiserfs.c          |  6 ++--
 libblkid/src/superblocks/romfs.c             |  2 +-
 libblkid/src/superblocks/silicon_raid.c      |  6 ++--
 libblkid/src/superblocks/squashfs.c          |  2 +-
 libblkid/src/superblocks/superblocks.c       | 13 ++++++--
 libblkid/src/superblocks/swap.c              | 24 +++++++--------
 libblkid/src/superblocks/sysv.c              |  4 +--
 libblkid/src/superblocks/ubifs.c             |  2 +-
 libblkid/src/superblocks/udf.c               | 16 +++++-----
 libblkid/src/superblocks/vfat.c              | 16 +++++-----
 libblkid/src/superblocks/via_raid.c          |  2 +-
 libblkid/src/superblocks/vmfs.c              |  4 +--
 libblkid/src/superblocks/vxfs.c              |  2 +-
 libblkid/src/superblocks/xfs.c               |  6 ++--
 libblkid/src/superblocks/zfs.c               |  6 ++--
 56 files changed, 294 insertions(+), 208 deletions(-)

-- 
1.8.1.4

