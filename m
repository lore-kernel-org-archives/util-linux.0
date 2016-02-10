Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37290 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbcBJLak (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Feb 2016 06:30:40 -0500
Date: Wed, 10 Feb 2016 12:30:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: J William Piggott <elseifthen@gmx.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: Configure fails on single builds
Message-ID: <20160210113038.ya3xdetffwknsavn@ws.net.home>
References: <56BA1630.7090106@gmx.com>
 <201602091819.29558.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201602091819.29558.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 09, 2016 at 06:19:29PM +0100, Ruediger Meier wrote:
> On Tuesday 09 February 2016, J William Piggott wrote:
> > commit 15167589fb40be9479e1afe261bea0bf23b33a83 causing single
> > builds (other than chrt) to fail:
> >
> > ./configure --disable-all-programs --enable-hwclock
> >
> > conditional \"HAVE_SCHED_SETATTR\" was never defined.
> > Usually this means the macro was only invoked conditionally.
> 
> I have fixed it for me like this, quick and dirty:
> 
> 
> diff --git a/configure.ac b/configure.ac
> index 4559573..cc9eb55 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1774,9 +1774,7 @@ UL_BUILD_INIT([chrt], [check])
>  UL_REQUIRES_BUILD([chrt], [schedutils])
>  AM_CONDITIONAL([BUILD_CHRT], [test "x$build_chrt" = xyes])
> 
> -AS_IF([test "x$build_chrt" = xyes], [
> -       UL_CHECK_SYSCALL([sched_setattr])
> -])
> +UL_CHECK_SYSCALL([sched_setattr])

UL_CHECK_SYSCALL function should not contain AM_CONDITIONAL, it's
unnecessary. We need only BUILD_ conditionals and HAVE_ for libs.

I'll fix it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
