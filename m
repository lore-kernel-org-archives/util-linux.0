Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46954 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab2IGQU6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Sep 2012 12:20:58 -0400
Date: Fri, 7 Sep 2012 18:20:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Moritz Barsnick <barsnick@gmx.net>
Cc: util-linux list <util-linux@vger.kernel.org>
Subject: Re: util-linux-2.22: backward compatibility of wdctl
Message-ID: <20120907162044.GE23242@x2.net.home>
References: <20120905112717.GA14130@sunshine.barsnick.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120905112717.GA14130@sunshine.barsnick.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 05, 2012 at 01:27:17PM +0200, Moritz Barsnick wrote:
> congratulations on util-linux 2.22. BTW, I recently took the liberty of
> refreshing the freshmeat aka freecode entry, and submitted an update
> for 2.22 today. I hope that's okay.

 ..arbitrary advertising is okay.

> Anyway, just for the fun of it, I was trying to compile util-linux on
> an SLES10 (SUSE Linux Enterprise) machine. That's one of those

 Do you know that we had -rc1 and -rc2 release? :-)

> enterprise distributions with somewhat ancient environments. ;-) But
> nothing out of the ordinary nowadays, I think.

 Well, it seems that you have kernel header < 2.6.18 (the macros has
 been added in Apr and May 2006).

>     CC     sys-utils/wdctl.o
>   sys-utils/wdctl.c:53:4: error: 'WDIOF_PRETIMEOUT' undeclared here (not in a function)
>   sys-utils/wdctl.c: In function 'read_watchdog':
>   sys-utils/wdctl.c:352:17: error: 'WDIOC_GETPRETIMEOUT' undeclared (first use in this function)
>   sys-utils/wdctl.c:352:17: note: each undeclared identifier is reported only once for each function it appears in
>   sys-utils/wdctl.c:352:3: warning: passing argument 2 of 'ioctl' makes integer from pointer without a cast [enabled by default]
>   In file included from sys-utils/wdctl.c:21:0:
>   /usr/include/sys/ioctl.h:42:12: note: expected 'long unsigned int' but argument is of type 'const struct wdflag *'
>   sys-utils/wdctl.c:354:17: error: 'WDIOC_GETTIMELEFT' undeclared (first use in this function)
>   sys-utils/wdctl.c:354:3: warning: passing argument 2 of 'ioctl' makes integer from pointer without a cast [enabled by default]
>   In file included from sys-utils/wdctl.c:21:0:
>   /usr/include/sys/ioctl.h:42:12: note: expected 'long unsigned int' but argument is of type 'const struct wdflag *'
>   make[2]: *** [sys-utils/wdctl.o] Error 1

 Fixed.

> This system's/kernel's watchdog.h doesn't have those #defines:

 Sure, it's always bad/expensive idea to mix old OS and new system
 packages.

> To add to the misery, it isn't possible to disable the build of wdctl
> AFAICT.

 Fixed, I have added --disable-wdctl.

> 2.6.16.60-0.58.1.3835.0.PTF.638363-smp

 yep...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
