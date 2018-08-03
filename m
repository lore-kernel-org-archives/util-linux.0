Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732251AbeHCMmX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 3 Aug 2018 08:42:23 -0400
Date: Fri, 3 Aug 2018 12:46:34 +0200
From: Karel Zak <kzak@redhat.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Sami Kerola <kerolasa@iki.fi>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>
Subject: Re: Debian has not dropped alpha - was: Re: [PATCH] hwclock: stop
 supporting alpha cpu architecture
Message-ID: <20180803104634.xweogydpjklaece7@ws.net.home>
References: <7ad8126b-cc76-c341-d1c5-d9461f9c1f5f@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7ad8126b-cc76-c341-d1c5-d9461f9c1f5f@physik.fu-berlin.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 28, 2018 at 01:01:45PM +0200, John Paul Adrian Glaubitz wrote:
> Hello!
> 
> I was just pointed towards this mail and wanted to give a quick
> heads up! The original claim in the first mail is not accurate.
> 
> While Debian has stopped supporting alpha **officially**, we are
> still supporting alpha in Debian Ports. In fact, Debian has more
> stable and working ports than Gentoo with many of them team-maintained
> by the Debian Ports team.
> 
> For an overview of the currently supported targets, see:
> 
> > https://buildd.debian.org/status/package.php?p=base-files&suite=sid
> 
> All architectures build the vast majority of packages without problems
> and alpha is actually one of the healhiest ports with over 90% of
> all packages being built:
> 
> > https://buildd.debian.org/stats/graph-ports-big.png
> 
> Please do not drop support for alpha in util-linux.

This is misunderstanding. It's mostly about Alpha specific RTC stuff
like RTC_EPOCH_* ioctls rather than about Alpha as architecture.

I have reviewed the patch and it seems Sami is wrong. The current
kernel still supports these ioctls. So, NACK from my point of view.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
