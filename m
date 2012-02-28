Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13425 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299Ab2B1OMg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Feb 2012 09:12:36 -0500
Date: Tue, 28 Feb 2012 15:12:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] conifigure: add a crosscompile path for
 scanf_cv_alloc_modifier
Message-ID: <20120228141226.GC22034@x2.net.home>
References: <1330103768-32139-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330103768-32139-1-git-send-email-bigeasy@linutronix.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 24, 2012 at 06:16:07PM +0100, Sebastian Andrzej Siewior wrote:
> This allows to building the package cross again. Since the return value
> is not used I guess there is little loss.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  configure.ac |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index d3b298c..c27e890 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -387,6 +387,8 @@ AC_CACHE_VAL([scanf_cv_alloc_modifier],
>        [scanf_cv_alloc_modifier=as],
>        [scanf_cv_alloc_modifier=no]
>      )
> +    ,
> +    [scanf_cv_alloc_modifier=no]
>    )
>  )

 Applied, thanks.

 ...but it means that you will compile the package without libmount.
 Is it expected? In the next release fsck will depend on the library,
 we have new mount and umount, ....

 Is it really true that your glibc is without %as / %ms ?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
