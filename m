Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932148AbdGCOwd (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 10:52:33 -0400
Date: Mon, 3 Jul 2017 16:52:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] path: use openat()
Message-ID: <20170703145228.exv6hbsqhwwd45w2@ws.net.home>
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
 <1499082781-16968-2-git-send-email-sweet_f_a@gmx.de>
 <20170703143949.pifm6ebon7dr3fww@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170703143949.pifm6ebon7dr3fww@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 03, 2017 at 04:39:49PM +0200, Karel Zak wrote:
> On Mon, Jul 03, 2017 at 01:52:56PM +0200, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > 
> > path_vcreate_with_prefix() is going to be removed.
> > 
> > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > ---
> >  lib/path.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 96 insertions(+), 15 deletions(-)
> > 
> > diff --git a/lib/path.c b/lib/path.c
> > index 79c1e7a..94181fe 100644
> > --- a/lib/path.c
> > +++ b/lib/path.c
> > @@ -26,18 +26,60 @@
> >  #include <stdio.h>
> >  #include <inttypes.h>
> >  #include <errno.h>
> > +#include <sys/stat.h>
> >  
> >  #include "all-io.h"
> >  #include "path.h"
> >  #include "nls.h"
> >  #include "c.h"
> >  
> > +static int rootfd = -1;
> >  static size_t prefixlen;
> > +static char pathbuf_prefix[PATH_MAX];
> >  static char pathbuf[PATH_MAX];
> 
> We use sysfs.c in shared libs, it means that global variables are
> unacceptable.
> 
> It would be better to have "struct path_cxt" and use it within "struct
> sysfs_cxt". For tools where we don't use "struct sysfs_cxt" (e.g.
> lscpu) we can directly use "struct path_cxt".
> 
> I guess it should be possible to replace sysfs_cxt->dir_fd with
> "struct path_cxt" where it points to $SYSROOT/sysfs/block/<device>.

And if we want to be real perfectionists than in sysfs.c we should
differentiate between block functions ($SYSROOT/sysfs/block/) and
another targets ($SYSROOT/sys/devices/system/cpu, ...etc).

Examples:

path.c only code:

 uint64_t x;
 struct path_cxt *path = path_new_context();

 path_set_system_root(path, argv[1]);

 path_read_s32(path, _PATH_SYS_CPU "/kernel_max", &x);


sysfs based code:

 uint64_t x;
 struct path_cxt *path = path_new_context();

 path_set_system_root(path, argv[1]);

 sysfs = sysfs_new_context(path);
 sysfs_assign_block_device(sysfs, devno, NULL);
 
 sysfs_read_u64(sysfs, "queue/minimum_io_size", &x);


Do you see more light in the proposal now? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
