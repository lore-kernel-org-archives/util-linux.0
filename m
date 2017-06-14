Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751727AbdFNKKT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Jun 2017 06:10:19 -0400
Date: Wed, 14 Jun 2017 12:10:14 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] fix various minor issues and warnings
Message-ID: <20170614101014.qnttyscgvcsruh4m@ws.net.home>
References: <20170612084958.22054-1-sweet_f_a@gmx.de>
 <20170613134719.qshrdtvvcystm4vd@ws.net.home>
 <597df757-fae1-c1f8-a5cf-dea177b2d9a3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <597df757-fae1-c1f8-a5cf-dea177b2d9a3@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 13, 2017 at 05:18:33PM +0200, Rüdiger Meier wrote:
> On 06/13/2017 03:47 PM, Karel Zak wrote:
> > On Mon, Jun 12, 2017 at 10:49:52AM +0200, Ruediger Meier wrote:
> > > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > > 
> > > Ruediger Meier (6):
> > >    tests: fix fincore, don't use variable COLUMNS
> > >    libmount: btrfs, remove unused setter functions
> > >    hwclock: fix warning [-Winvalid-noreturn]
> > >    misc: fix gcc-7 sprintf warnings -Wformat-overflow
> > >    misc: fix gcc-7 snprintf warnings -Wformat-truncation
> > >    libblkid: fix gcc-7 warning -Wint-in-bool-context
> > > 
> > >   lib/loopdev.c                    |  2 +-
> > >   lib/sysfs.c                      |  4 ++--
> > >   libblkid/src/devname.c           |  2 +-
> > >   libblkid/src/superblocks/exfat.c |  4 ++--
> > >   libmount/src/btrfs.c             |  4 ----
> > >   login-utils/last.c               |  2 +-
> > >   sys-utils/hwclock.c              |  2 +-
> > >   sys-utils/hwclock.h              |  3 ++-
> > >   tests/ts/fincore/count           | 12 ++++++------
> > >   9 files changed, 16 insertions(+), 19 deletions(-)
> > 
> > Seems better than the previous version from Sami (May 27).
> 
> These fixed are completely independent/unrelated to the other pull
> request from Sami. Sami's PR just motivated me to try out gcc-7 too.

Yep, you both tried to fix the sprintf warnings, your version with
NAME_MAX seems better.

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
