Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753091AbdFMNr2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 09:47:28 -0400
Date: Tue, 13 Jun 2017 15:47:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] fix various minor issues and warnings
Message-ID: <20170613134719.qshrdtvvcystm4vd@ws.net.home>
References: <20170612084958.22054-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170612084958.22054-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 12, 2017 at 10:49:52AM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Ruediger Meier (6):
>   tests: fix fincore, don't use variable COLUMNS
>   libmount: btrfs, remove unused setter functions
>   hwclock: fix warning [-Winvalid-noreturn]
>   misc: fix gcc-7 sprintf warnings -Wformat-overflow
>   misc: fix gcc-7 snprintf warnings -Wformat-truncation
>   libblkid: fix gcc-7 warning -Wint-in-bool-context
> 
>  lib/loopdev.c                    |  2 +-
>  lib/sysfs.c                      |  4 ++--
>  libblkid/src/devname.c           |  2 +-
>  libblkid/src/superblocks/exfat.c |  4 ++--
>  libmount/src/btrfs.c             |  4 ----
>  login-utils/last.c               |  2 +-
>  sys-utils/hwclock.c              |  2 +-
>  sys-utils/hwclock.h              |  3 ++-
>  tests/ts/fincore/count           | 12 ++++++------
>  9 files changed, 16 insertions(+), 19 deletions(-)

Seems better than the previous version from Sami (May 27).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
