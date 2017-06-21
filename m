Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:58479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbdFUQ4I (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 12:56:08 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MFtf4-1dbSAC1RFm-00Ewnf for <util-linux@vger.kernel.org>; Wed, 21 Jun 2017
 18:56:06 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: overriding STRTOXX_EXIT_CODE does not work
Date: Wed, 21 Jun 2017 18:56:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201706211856.05354.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I found a little annoying issue. The trick to re-define
STRTOXX_EXIT_CODE (see a99c913091c, 2012-03-30) can't work.
When compiling strutils.c it will always use the default from
strutils.h


STRTOXX_EXIT_CODE is used only at 3 places:

disk-utils/fsck.c:#define STRTOXX_EXIT_CODE     FSCK_EX_USAGE
misc-utils/blkid.c:#define STRTOXX_EXIT_CODE    BLKID_EXIT_OTHER
sys-utils/tunelp.c:#define STRTOXX_EXIT_CODE    3


But there are more candidates where the return codes are broken
since strutils.h was introduced, for example here f150ac37.

$ grep -l "strutils.h" `git grep -l   "FINDFS_\|MNT_EX\|MKFS_EX\|FSCK_EX" --  "*.c"`
disk-utils/fsck.c
disk-utils/fsck.cramfs.c
disk-utils/fsck.minix.c
disk-utils/mkfs.cramfs.c
disk-utils/mkfs.minix.c
libmount/src/context_mount.c
libmount/src/context_umount.c
sys-utils/fstrim.c
sys-utils/mount.c


Should we make STRTOXX_EXIT_CODE usable by moving  strutils.c to
strutils.h, like optutils.h? Or any other ideas?

cu,
Rudi
