Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbdBMNTC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Feb 2017 08:19:02 -0500
Date: Mon, 13 Feb 2017 14:18:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Yuri Chornoivan <yurchor@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix word repetitions
Message-ID: <20170213131849.aznpjhnfvctxspkr@ws.net.home>
References: <1486724704-8127-1-git-send-email-yurchor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486724704-8127-1-git-send-email-yurchor@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 10, 2017 at 01:05:04PM +0200, Yuri Chornoivan wrote:
>  Documentation/howto-pull-request.txt | 2 +-
>  disk-utils/partx.c                   | 2 +-
>  lib/sysfs.c                          | 2 +-
>  libmount/src/cache.c                 | 2 +-
>  libmount/src/fs.c                    | 2 +-
>  libmount/src/tab.c                   | 2 +-
>  libsmartcols/samples/fromfile.c      | 2 +-
>  login-utils/last.c                   | 2 +-
>  misc-utils/blkid.c                   | 2 +-
>  misc-utils/cal.c                     | 2 +-
>  misc-utils/findmnt.c                 | 2 +-
>  misc-utils/look.c                    | 2 +-
>  misc-utils/lsblk.c                   | 2 +-
>  misc-utils/test_uuidd.c              | 2 +-
>  misc-utils/wipefs.c                  | 2 +-
>  sys-utils/chcpu.c                    | 2 +-
>  sys-utils/dmesg.c                    | 2 +-
>  sys-utils/fallocate.c                | 2 +-
>  sys-utils/fsfreeze.c                 | 2 +-
>  sys-utils/hwclock.c                  | 4 ++--
>  sys-utils/mount.c                    | 2 +-
>  sys-utils/swapon.c                   | 2 +-
>  sys-utils/umount.c                   | 2 +-
>  sys-utils/wdctl.c                    | 2 +-
>  term-utils/agetty.c                  | 2 +-
>  25 files changed, 26 insertions(+), 26 deletions(-)

 Applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
