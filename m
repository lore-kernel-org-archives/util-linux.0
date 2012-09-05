Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:61737 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab2IENhw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 5 Sep 2012 09:37:52 -0400
Message-ID: <504755AC.9080008@bernhard-voelker.de>
Date: Wed, 05 Sep 2012 15:37:48 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Moritz Barsnick <barsnick@gmx.net>
CC: util-linux list <util-linux@vger.kernel.org>
Subject: Re: util-linux-2.22: backward compatibility of wdctl
References: <20120905112717.GA14130@sunshine.barsnick.net>
In-Reply-To: <20120905112717.GA14130@sunshine.barsnick.net>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 09/05/2012 01:27 PM, Moritz Barsnick wrote:
> Hi everyone,
> congratulations on util-linux 2.22. BTW, I recently took the liberty of
> refreshing the freshmeat aka freecode entry, and submitted an update
> for 2.22 today. I hope that's okay.
> 
> Anyway, just for the fun of it, I was trying to compile util-linux on
> an SLES10 (SUSE Linux Enterprise) machine. That's one of those
> enterprise distributions with somewhat ancient environments. ;-) But
> nothing out of the ordinary nowadays, I think.
> 
> I didn't succeed, because wdctl makes use of #defines which are not
> defined on this OS:
> 
>   make[2]: Entering directory `/tmp/Bui/util-linux/util-linux-2.22'
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
> 
> This system's/kernel's watchdog.h doesn't have those #defines:
> 
> [...]
>
> To add to the misery, it isn't possible to disable the build of wdctl
> AFAICT.

You can use a crude hack to work around building wdctl:

  $ touch sys-utils/wdctl.o wdctl ; make

but this won't make you happy. You'll most propably hit other
problems. This is from my SLES 10.4 system:

  In file included from disk-utils/partx.h:5,
                   from disk-utils/partx.c:32:
  /usr/include/linux/blkpg.h:36: error: expected ‘:’, ‘,’, ‘;’, ‘}’ or ‘__attribute__’ before ‘*’ token
  In file included from disk-utils/partx.c:32:
  disk-utils/partx.h: In function ‘partx_del_partition’:
  disk-utils/partx.h:32: error: ‘struct blkpg_ioctl_arg’ has no member named ‘data’
  disk-utils/partx.h: In function ‘partx_add_partition’:
  disk-utils/partx.h:51: error: ‘struct blkpg_ioctl_arg’ has no member named ‘data’
  disk-utils/partx.h: In function ‘partx_resize_partition’:
  disk-utils/partx.h:70: error: ‘struct blkpg_ioctl_arg’ has no member named ‘data’
  make[2]: *** [disk-utils/partx-partx.o] Error 1

Temporarily defining __user to nothing seems to work:

  $ make CFLAGS='-D__user='

... although this is another bad workaround. ;-(

Have a nice day,
Berny
