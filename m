Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbcIGMMh (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Sep 2016 08:12:37 -0400
Date: Wed, 7 Sep 2016 14:12:35 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux stable v2.28.2
Message-ID: <20160907121235.yv2k6ujpb4qhoclo@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The util-linux stable release v2.28.2 is available at

  http://ftp.kernel.org/pub/linux/utils/util-linux/v2.28/

Feedback and bug reports, as always, are welcomed.

    Karel


util-linux 2.28.2 Release Notes
===============================

blkdev:
   - guard against missing DIOCGDINFO on FreeBSD 11  [Franco Fichtner]
build-sys:
   - add parisc to define ARCH_  [Karel Zak]
docs:
   - update AUTHORS file  [Karel Zak]
lib/loopdev:
   - Set errno in is_loopdev on error  [Tobias Stoeckmann]
libblkid:
   - Avoid OOB access on illegal ZFS superblocks  [Tobias Stoeckmann]
   - Check that cluster size is nonzero when probing exFAT  [Rostislav Skudnov]
   - [exfat] Limit maximum number of iterations in find_label  [Rostislav Skudnov]
libsmartcols:
   - fix empty cell padding  [Karel Zak]
   - fix padding for non-maxout output  [Karel Zak]
lsns:
   - missing ns/<name> is not error  [Karel Zak]
pathnames:
   - guard clashing definitions on FreeBSD  [Franco Fichtner]
po:
   - merge changes  [Karel Zak]
sfdisk:
   - revert exit with error if rereading partition table fails  [Karel Zak]
tests:
   - Fix fdisk/id and fdisk/mbr-nondos-mode on Sparc  [James Clarke]
   - keep 'hppa' in fdisk/bsd test too  [Karel Zak]
   - really fix fdisk/bsd for hppa  [Helge Deller]
umount:
   - fix obsolete info about loop= in umount.8  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
