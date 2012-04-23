Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22117 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888Ab2DWKZ1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 06:25:27 -0400
Date: Mon, 23 Apr 2012 12:25:16 +0200
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: util-linux <util-linux@vger.kernel.org>, Sami Kerola <kerolasa@iki.fi>
Subject: Re: eject on Cygwin?
Message-ID: <20120423102516.GA11847@x2.net.home>
References: <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A097@MCHP058A.global-ad.net>
 <20120423094420.GA8144@x2.net.home>
 <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A0B9@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A0B9@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 23, 2012 at 11:49:37AM +0200, Voelker, Bernhard wrote:
> Karel Zak wrote:
> 
> > On Mon, Apr 23, 2012 at 11:31:11AM +0200, Voelker, Bernhard wrote:
> > > Is there a specific reason for this line in configure.ac?
> > >   UL_REQUIRES_LINUX([eject])
> > > 
> > > Can't Cygwin handle /dev/scd0 correctly? 
> > 
> >  I don't know, the code also depends on /sys to detect if the device
> >  is removable, it calls umount(2) syscall, etc.
> 
> okay, thanks.
> Anyway, porting u-l to cygwin is not much fun anymore,
> e.g. due to new close_stdout() which needs __fpending, and
> lib/randutils.c needs sys/syscall.h to check if __NR_gettid
> is defined etc.

It should be so pretty simple to check for the unportable functions
in configure and add some #ifdef to include/closestream.h. It's no
problem if close_stdout() will do nothing on some platforms. Sami?

Anyway, we follow coreutils here, I guess coreutils already have some
fallbacks (they care about portability more that u-l :-).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
