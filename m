Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 0/6] fix various minor issues and warnings
Date: Wed, 14 Jun 2017 13:06:46 +0200
Cc: util-linux@vger.kernel.org
References: <20170612084958.22054-1-sweet_f_a@gmx.de> <597df757-fae1-c1f8-a5cf-dea177b2d9a3@gmx.de> <20170614101014.qnttyscgvcsruh4m@ws.net.home>
In-Reply-To: <20170614101014.qnttyscgvcsruh4m@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706141306.46931.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 14 June 2017, Karel Zak wrote:
> On Tue, Jun 13, 2017 at 05:18:33PM +0200, R=FCdiger Meier wrote:
> > On 06/13/2017 03:47 PM, Karel Zak wrote:
> > > On Mon, Jun 12, 2017 at 10:49:52AM +0200, Ruediger Meier wrote:
> > > > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > > >
> > > > Ruediger Meier (6):
> > > >    tests: fix fincore, don't use variable COLUMNS
> > > >    libmount: btrfs, remove unused setter functions
> > > >    hwclock: fix warning [-Winvalid-noreturn]
> > > >    misc: fix gcc-7 sprintf warnings -Wformat-overflow
> > > >    misc: fix gcc-7 snprintf warnings -Wformat-truncation
> > > >    libblkid: fix gcc-7 warning -Wint-in-bool-context
> > > >
> > > >   lib/loopdev.c                    |  2 +-
> > > >   lib/sysfs.c                      |  4 ++--
> > > >   libblkid/src/devname.c           |  2 +-
> > > >   libblkid/src/superblocks/exfat.c |  4 ++--
> > > >   libmount/src/btrfs.c             |  4 ----
> > > >   login-utils/last.c               |  2 +-
> > > >   sys-utils/hwclock.c              |  2 +-
> > > >   sys-utils/hwclock.h              |  3 ++-
> > > >   tests/ts/fincore/count           | 12 ++++++------
> > > >   9 files changed, 16 insertions(+), 19 deletions(-)
> > >
> > > Seems better than the previous version from Sami (May 27).
> >
> > These fixed are completely independent/unrelated to the other pull
> > request from Sami. Sami's PR just motivated me to try out gcc-7
> > too.
>
> Yep, you both tried to fix the sprintf warnings, your version with
> NAME_MAX seems better.

Ooops, I didn't even noticed and could merge all together without=20
confilcts.

> Applied, thanks.
>
>     Karel
