Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36242 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753455AbcKSJmu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 19 Nov 2016 04:42:50 -0500
Received: by mail-qt0-f172.google.com with SMTP id w33so177308661qtc.3
        for <util-linux@vger.kernel.org>; Sat, 19 Nov 2016 01:42:49 -0800 (PST)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <17647d86-6faa-1898-22df-3303d9ad8a7e@gmail.com>
References: <17647d86-6faa-1898-22df-3303d9ad8a7e@gmail.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Sat, 19 Nov 2016 10:42:28 +0100
Message-ID: <CAKgNAkjfvDmV4-P81-nuab=xTis_KWbTcuOsTNkbc=b9iBC-aw@mail.gmail.com>
Subject: Re: Patches to util-linux man pages
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel,

Ping for this patch series! I think it's pretty straightforward. Is
something blocking it from being applied?

Cheers,

Michael


On 10 November 2016 at 11:59, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> Hello Karel,
>
> I have a series of patches that contain fixes for various
> manual pages in util-linux. The early patches in the series
> fix typos and inconsistencies across many pages.
>
> The last two patches make some improvements to nsenter(1) and
> unshare(1), in particular, by adding more specific cross references
> to other pages that explain the relevant namespace concepts in
> more detail.
>
> Please apply.
>
> Cheers,
>
> Michael
>
> Michael Kerrisk (12):
>   Fix typo in page cross reference (capabilities(7), not capability(7))
>   Place SEE ALSO entries in order
>   Correctly format page cross references
>   Fix page cross references
>   Fix section number in lockf() page xref
>   Fix reference for scheduling discussion
>   Fix formatting errors in page cross references
>   Relace reference to sigvec(2) with sigaction(2)
>   SEE ALSO: add cross reference to namespaces(7)
>   Provide better cross references for namespace concepts
>   Provide better cross references for namespace concepts
>   IPC namespaces also isolate POSIX message queues
>
>  disk-utils/cfdisk.8         |  4 +--
>  disk-utils/fdformat.8       |  4 +--
>  disk-utils/fdisk.8          |  4 +--
>  disk-utils/fsck.8           |  6 ++---
>  disk-utils/fsck.minix.8     |  2 +-
>  disk-utils/mkfs.cramfs.8    |  4 +--
>  disk-utils/mkfs.minix.8     |  2 +-
>  disk-utils/swaplabel.8      |  6 ++---
>  libuuid/man/uuid_generate.3 |  6 ++---
>  login-utils/chfn.1          |  2 +-
>  login-utils/last.1          |  4 +--
>  login-utils/login.1         |  6 ++---
>  login-utils/runuser.1       |  8 +++---
>  login-utils/su.1            |  6 ++---
>  login-utils/vipw.8          |  2 +-
>  misc-utils/blkid.8          |  2 +-
>  misc-utils/findmnt.8        |  6 ++---
>  misc-utils/getopt.1         |  4 +--
>  misc-utils/kill.1           |  2 +-
>  misc-utils/logger.1         |  2 +-
>  misc-utils/lsblk.8          |  4 +--
>  misc-utils/lslocks.8        |  2 +-
>  misc-utils/mcookie.1        |  2 +-
>  schedutils/chrt.1           |  2 +-
>  schedutils/taskset.1        |  6 ++---
>  sys-utils/blkdiscard.8      |  2 +-
>  sys-utils/dmesg.1           |  4 +--
>  sys-utils/eject.1           |  2 +-
>  sys-utils/fallocate.1       |  4 +--
>  sys-utils/fstab.5           |  6 ++---
>  sys-utils/fstrim.8          |  4 +--
>  sys-utils/ipcrm.1           |  2 +-
>  sys-utils/ipcs.1            | 12 ++++-----
>  sys-utils/lsipc.1           | 12 ++++-----
>  sys-utils/lsns.8            |  2 +-
>  sys-utils/mount.8           | 16 +++++------
>  sys-utils/nsenter.1         | 65 +++++++++++++++++++++++++++++++++------------
>  sys-utils/pivot_root.8      |  2 +-
>  sys-utils/prlimit.1         |  4 +--
>  sys-utils/setpriv.1         |  4 +--
>  sys-utils/swapon.8          |  6 ++---
>  sys-utils/switch_root.8     |  4 +--
>  sys-utils/tunelp.8          |  2 +-
>  sys-utils/umount.8          |  4 +--
>  sys-utils/unshare.1         | 63 ++++++++++++++++++++++++++++++++++---------
>  term-utils/mesg.1           |  2 +-
>  term-utils/script.1         |  2 +-
>  term-utils/setterm.1        |  6 ++---
>  text-utils/colcrt.1         |  4 +--
>  text-utils/more.1           |  4 +--
>  text-utils/pg.1             |  4 +--
>  text-utils/tailf.1          |  4 +--
>  52 files changed, 207 insertions(+), 137 deletions(-)
>
> --
> 2.5.5
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
