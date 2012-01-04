Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21678 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349Ab2ADNj4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 Jan 2012 08:39:56 -0500
Date: Wed, 4 Jan 2012 14:39:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 3/3] tools/checkxalloc.sh: add new code checking script
Message-ID: <20120104133953.GE24350@x2.net.home>
References: <1324388164-2112-1-git-send-email-dreisner@archlinux.org>
 <1324388164-2112-3-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324388164-2112-3-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 20, 2011 at 08:36:04AM -0500, Dave Reisner wrote:
> Ask and you shall receive ;)

 Thanks :-)

>  tools/checkxalloc.sh |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>  create mode 100755 tools/checkxalloc.sh
> 
> diff --git a/tools/checkxalloc.sh b/tools/checkxalloc.sh
> new file mode 100755
> index 0000000..f8f8c8c
> --- /dev/null
> +++ b/tools/checkxalloc.sh
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +#
> +# Find files which include the xalloc.h header, but which still call
> +# the unwrapped calloc and malloc.
> +#
> +
> +cd "$(git rev-parse --show-toplevel)" || {
> +  echo "error: failed to chdir to git root"
> +  exit 1
> +}
> +
> +git grep -zl '#include "xalloc.h"' |
> +  xargs -0 grep -nwE '[^x](([cm]|re)alloc|strdup)\('

 Applied, with small improvement -- we need a proper return value
 (xargs returns too funny numbers) to make it usable from top-level
 Makefile.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
