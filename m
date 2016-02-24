Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbcBXRrx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Feb 2016 12:47:53 -0500
Date: Wed, 24 Feb 2016 18:47:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: rc1 planning
Message-ID: <20160224174752.6kg25zaiswcxyyqt@ws.net.home>
References: <20160224125641.kw2t37ofjhmealej@ws.net.home>
 <201602241550.21863.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201602241550.21863.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 24, 2016 at 03:50:21PM +0100, Ruediger Meier wrote:
> On Wednesday 24 February 2016, Karel Zak wrote:
> >  Hi,
> >
> >  I'd like to release v2.28-rc1 ASAP, but the rest of this week and
> > all next week I have vacation (and all next week I'm going to be
> > off-line somewhere in Atlantic). So, my plan is 7th or 8th March.
> >
> >  remaining issues:
> >
> >   * btrfs loop devs in libmount
> >
> >   * libblkid vs. CDROMs (check if last two 2K sectors are readable,
> > if not reduce probing area)    [me]
> >
> >   * add time formatting functions for ISO and ctime [not urgent]
> >
> >   * cleanup openat() related function [not urgent, Rudi?]
> 
> I've changed my mind a bit about lib/at.c removal because it's used by 
> sysfs.c and we would lose libblkid and fdisk on non-linux systems. I 
> will review first whether we could build libblkid without sysfs for 
> non-Linux.

 The libblkid is optional for libfdisk, I cannot imagine libblkid without
 sysfs :-)

> Regarding my stupid commit ...
>   8b9cf26a "lib: fix unused parameters and variables"
> ... next time I would try to add our new "NO_UNUSED_WARN_CFLAGS" just 
> for single source files. Not using __unused macros would keep our 
> heavily ifdef'ed sources more readable.
> 
> >   * add --zeroout to blkdiscard [me]
> >
> >   * fix look(1) [https://github.com/karelzak/util-linux/issues/284]
> >
> >   * cleanup docs, gtk-doc warnings, etc.
> 
> My favorite warning one could fix is this one:

Frankly, my favorite solution is to drop gtk-docs and use something
else. I like gtk-docs html output, but the rest (warnings, docs
formatting, Makefile integration, ...) is painful.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
