Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 1/6] path: use openat()
Date: Mon, 3 Jul 2017 18:11:56 +0200
Cc: util-linux@vger.kernel.org
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de> <20170703143949.pifm6ebon7dr3fww@ws.net.home> <20170703145228.exv6hbsqhwwd45w2@ws.net.home>
In-Reply-To: <20170703145228.exv6hbsqhwwd45w2@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201707031811.56680.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 03 July 2017, Karel Zak wrote:
> On Mon, Jul 03, 2017 at 04:39:49PM +0200, Karel Zak wrote:
> > On Mon, Jul 03, 2017 at 01:52:56PM +0200, Ruediger Meier wrote:
> > > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > >
> > > path_vcreate_with_prefix() is going to be removed.
> > >
> > > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > > ---
> > >  lib/path.c | 111
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++++--------- 1
> > > file changed, 96 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/lib/path.c b/lib/path.c
> > > index 79c1e7a..94181fe 100644
> > > --- a/lib/path.c
> > > +++ b/lib/path.c
> > > @@ -26,18 +26,60 @@
> > >  #include <stdio.h>
> > >  #include <inttypes.h>
> > >  #include <errno.h>
> > > +#include <sys/stat.h>
> > >
> > >  #include "all-io.h"
> > >  #include "path.h"
> > >  #include "nls.h"
> > >  #include "c.h"
> > >
> > > +static int rootfd = -1;
> > >  static size_t prefixlen;
> > > +static char pathbuf_prefix[PATH_MAX];
> > >  static char pathbuf[PATH_MAX];
> >
> > We use sysfs.c in shared libs, it means that global variables are
> > unacceptable.

Yes I understand. This global way was just for first tests without 
changing much code. To be honest, while I was very happy first about 
quick results, I am now a bit unsure whether this sysroot feature will 
be much useful at all.

See, even lscpu --sysroot does not work fully transparently. We have to 
ignore "Architecture". So maybe we would also need a fake-syscall 
interface for many cases!? Also we are sometimes writing to /sys and 
probably expect some events.

I wonder if it wouldn't be easier to construct chroot or container 
environments with whatever /sys, /proc, /etc. to test certain things.

So I thought we could use my quick-and-dirty approach to implement some 
more --sysroot tests just to see if we will get something useful at 
all.

cu,
Rudi

> > It would be better to have "struct path_cxt" and use it within
> > "struct sysfs_cxt". For tools where we don't use "struct sysfs_cxt"
> > (e.g. lscpu) we can directly use "struct path_cxt".
> >
> > I guess it should be possible to replace sysfs_cxt->dir_fd with
> > "struct path_cxt" where it points to $SYSROOT/sysfs/block/<device>.

> And if we want to be real perfectionists than in sysfs.c we should
> differentiate between block functions ($SYSROOT/sysfs/block/) and
> another targets ($SYSROOT/sys/devices/system/cpu, ...etc).
>
> Examples:
>
> path.c only code:
>
>  uint64_t x;
>  struct path_cxt *path = path_new_context();
>
>  path_set_system_root(path, argv[1]);
>
>  path_read_s32(path, _PATH_SYS_CPU "/kernel_max", &x);
>
>
> sysfs based code:
>
>  uint64_t x;
>  struct path_cxt *path = path_new_context();
>
>  path_set_system_root(path, argv[1]);
>
>  sysfs = sysfs_new_context(path);
>  sysfs_assign_block_device(sysfs, devno, NULL);
>
>  sysfs_read_u64(sysfs, "queue/minimum_io_size", &x);
>
>
> Do you see more light in the proposal now? :-)
