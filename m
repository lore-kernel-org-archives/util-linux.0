Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41046 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbbGXUJa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jul 2015 16:09:30 -0400
Date: Fri, 24 Jul 2015 22:09:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Joel Holdsworth <joel@airwebreathe.org.uk>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org,
        Joel Holdsworth <joel.holdsworth@vcatechnology.com>
Subject: Re: [PATCH] build-sys: cal requires both ncurses and tinfo
Message-ID: <20150724200926.GF3432@ws.net.home>
References: <1437692199-7557-1-git-send-email-joel.holdsworth@vcatechnology.com>
 <55B1D9F7.4040109@bernhard-voelker.de>
 <20150724075612.GE3432@ws.net.home>
 <55B276F1.5070706@airwebreathe.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B276F1.5070706@airwebreathe.org.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 24, 2015 at 06:33:37PM +0100, Joel Holdsworth wrote:
> Ok, so cal can build without ncurses and/or tinfo - fine ok.
> 
> The problem I have is with misc-utils/Makemodule.am:14
> 
> https://git.kernel.org/cgit/utils/util-linux/util-linux.git/tree/misc-utils/Makemodule.am?h=stable%2Fv2.26#n14
> 
> ...this is making it link with -ltinfo, which fails because I'm not
> providing it. Would it be more correct to make NCURSES_LIBS and
> TINFO_LIBS become empty when they're not available? Is this how it's
> meant to work? Did it ever work this way previously?
> 
> I'm slightly suspicious of my cross-build setup if configure is picking
> up "-ltinfo" dependencies from the host system, but even with
> '--disable-tinfo', TINFO_LIBS is still not set to "".
> 
> Also having UL_BUILD_INIT([cal], [yes]) to force cal to always be built
> seem ridiculous; in fact why should any of the tools be forced? The user
> should be able to mix and match whatever programs they want to have.
> 
> Another related issue is that I was hoping to be able to do
> '--disable-all-programs', then '--enable-XXX' the ones I need one by one
> - but the disable-all flag seems to take precedence right now.
> 
> Can someone suggest what a patch to fix this should be like?

I'll try to improve it next week, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
