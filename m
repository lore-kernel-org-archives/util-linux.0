Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43217 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754955AbbBPNqd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Feb 2015 08:46:33 -0500
Date: Mon, 16 Feb 2015 14:46:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: libsmartcols patch
Message-ID: <20150216134628.GI11948@ws.net.home>
References: <54A0AE98.70503@ubuntu.com>
 <20150216050053.GA4075@vapier>
 <20150216102726.GH11948@ws.net.home>
 <20150216104848.GK4075@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150216104848.GK4075@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 16, 2015 at 05:48:48AM -0500, Mike Frysinger wrote:
> > > general note: libraries should never assert/abort/exit.
> > 
> >  what about segfault?
> 
> that's a red herring.  you can't guarantee your codebase is bug free, but that 
> doesn't mean encouraging a policy of committing suicide is a good thing.

suicide + usable message is better than segfault

> >  We use assert to detect fatal internal library bugs, for mistakes in
> >  applications (e.g. incomplete arguments) it returns -EINVAL.
> 
> libsmartcols/src/table_print.c:
> int scols_print_table(struct libscols_table *tb)
> {
> ...
>     assert(tb);
>     if (!tb)
>         return -1;

this is mistake, fixed in libsmartcols and libmount, I'll later fix it
in libfdisk too.

> >  Its' possible to remove CONFIG_LIBSMARTCOLS_ASSERT from smartcolsP.h,
> >  but I don't think the library is already well tested.
> 
> odd ... why is that reimplementing the wheel ?  the standard assert.h already 
> supports NDEBUG for turning off asserts.
> 
> i see there's a bunch of such knobs in the codebase.  time for a 
> --{en,dis}able-asserts configure flag ?  you could delete all the existing 
> CONFIG_xxx_ASSERT defines and simply rely on configure adding -DNDEBUG to 
> CPPFLAGS.

Maybe, the idea has been to keep it in our hands and force people to
use asserts for the "not yet well tested" libs.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
