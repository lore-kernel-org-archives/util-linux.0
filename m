Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754062AbdGCOjx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 10:39:53 -0400
Date: Mon, 3 Jul 2017 16:39:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] path: use openat()
Message-ID: <20170703143949.pifm6ebon7dr3fww@ws.net.home>
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
 <1499082781-16968-2-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499082781-16968-2-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 03, 2017 at 01:52:56PM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> path_vcreate_with_prefix() is going to be removed.
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  lib/path.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 96 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/path.c b/lib/path.c
> index 79c1e7a..94181fe 100644
> --- a/lib/path.c
> +++ b/lib/path.c
> @@ -26,18 +26,60 @@
>  #include <stdio.h>
>  #include <inttypes.h>
>  #include <errno.h>
> +#include <sys/stat.h>
>  
>  #include "all-io.h"
>  #include "path.h"
>  #include "nls.h"
>  #include "c.h"
>  
> +static int rootfd = -1;
>  static size_t prefixlen;
> +static char pathbuf_prefix[PATH_MAX];
>  static char pathbuf[PATH_MAX];

We use sysfs.c in shared libs, it means that global variables are
unacceptable.

It would be better to have "struct path_cxt" and use it within "struct
sysfs_cxt". For tools where we don't use "struct sysfs_cxt" (e.g.
lscpu) we can directly use "struct path_cxt".

I guess it should be possible to replace sysfs_cxt->dir_fd with
"struct path_cxt" where it points to $SYSROOT/sysfs/block/<device>.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
