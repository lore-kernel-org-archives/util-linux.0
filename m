Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbdBIKmQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 9 Feb 2017 05:42:16 -0500
Date: Thu, 9 Feb 2017 11:33:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Carlos Santos <casantos@datacom.ind.br>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: improve detection of the "isnan" function in
 uClibc
Message-ID: <20170209103350.hy4u5iulzx6chl2m@ws.net.home>
References: <1486567656-22277-1-git-send-email-casantos@datacom.ind.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486567656-22277-1-git-send-email-casantos@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 08, 2017 at 01:27:36PM -0200, Carlos Santos wrote:
> Since commit beceb14b450ded6560ed743634a5e80604a8edf3, MATH_LIBS is set
> to "-lm" when the isnan function is detected. In uClibc, however, isnan
> is a macro that calls __isnan, __isnanf, or __isnanl, depending on the
> size of the argument (double, float or long double).
> 
> Fixes:
>   http://autobuild.buildroot.net/results/2c2/2c29a78ed81ca844a87dcd076ab3e14ea080296d/
>   http://autobuild.buildroot.net/results/404/404b10f359b2ae8a7216729fa1bab37fed2d3d4c/
> 
> Signed-off-by: Carlos Santos <casantos@datacom.ind.br>
> ---
>  configure.ac | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 3759921..3bb3ba8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -435,6 +435,7 @@ AM_CONDITIONAL([HAVE_OPENAT], [test "x$have_openat" = xyes])
>  
>  AC_CHECK_FUNCS([isnan], [],
>  	[AC_CHECK_LIB([m], [isnan], [MATH_LIBS="-lm"])]
> +	[AC_CHECK_LIB([m], [__isnan], [MATH_LIBS="-lm"])]
>  )
>  AC_SUBST([MATH_LIBS])

Applied, thanks. (It would be possible to use AC_COMPILE_IFELSE() monster, but if
AC_CHECK_LIB() is good enough than it's probably better.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
