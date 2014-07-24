Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f51.google.com ([209.85.192.51]:57721 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757795AbaGXQwb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 24 Jul 2014 12:52:31 -0400
Received: by mail-qg0-f51.google.com with SMTP id a108so3491740qge.38
        for <util-linux@vger.kernel.org>; Thu, 24 Jul 2014 09:52:30 -0700 (PDT)
Date: Thu, 24 Jul 2014 12:52:26 -0400
From: Dave Reisner <d@falconindy.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix switch_root/pivot_root cut-n-paste error in
 configure.ac
Message-ID: <20140724165226.GB519@rampage>
References: <1406137142-15441-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406137142-15441-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 23, 2014 at 07:39:02PM +0200, Andreas Henriksson wrote:
> The "linux only" check for pivot_root seems to suffer from
> a cut-n-paste problem from the earlier switch_root part.
> 
> Signed-off-by: Andreas Henriksson <andreas@fatal.se>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index db53dff..aae2456 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1193,7 +1193,7 @@ AC_ARG_ENABLE([pivot_root],
>    [], [UL_DEFAULT_ENABLE([pivot_root], [check])]
>  )
>  UL_BUILD_INIT([pivot_root])
> -UL_REQUIRES_LINUX([switch_root])
> +UL_REQUIRES_LINUX([pivot_root])

Is this really correct? Seems to me like the check should simply be
removed. In sys-utils/pivot_root.c, we have the following:

  #define pivot_root(new_root,put_old) syscall(SYS_pivot_root,new_root,put_old)

So, the subsequent check for the syscall seems like the only necessary
check needed. As is, I think that u-l now fails to build in places where
the pivot_root wrapper doesn't exist in the libc, but the syscall exists
(does such a platform even exist?).

Cheers,
dave

>  UL_REQUIRES_SYSCALL_CHECK([pivot_root], [UL_CHECK_SYSCALL([pivot_root])])
>  AM_CONDITIONAL([BUILD_PIVOT_ROOT], [test "x$build_pivot_root" = xyes])
>  
> -- 
> 2.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
