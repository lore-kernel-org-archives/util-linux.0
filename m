Return-Path: util-linux-owner@vger.kernel.org
Received: from b.painless.aa.net.uk ([81.187.30.52]:44488 "EHLO
	b.painless.aa.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbbGXSm4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2015 14:42:56 -0400
Message-ID: <55B276F1.5070706@airwebreathe.org.uk>
Date: Fri, 24 Jul 2015 18:33:37 +0100
From: Joel Holdsworth <joel@airwebreathe.org.uk>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
CC: Joel Holdsworth <joel.holdsworth@vcatechnology.com>
Subject: Re: [PATCH] build-sys: cal requires both ncurses and tinfo
References: <1437692199-7557-1-git-send-email-joel.holdsworth@vcatechnology.com> <55B1D9F7.4040109@bernhard-voelker.de> <20150724075612.GE3432@ws.net.home>
In-Reply-To: <20150724075612.GE3432@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24/07/15 08:56, Karel Zak wrote:
> On Fri, Jul 24, 2015 at 08:23:51AM +0200, Bernhard Voelker wrote:
>> On 07/24/2015 12:56 AM, Joel Holdsworth wrote:
>>> This fixes a bug in the build system when building without ncurses
>>> and tinfo. When cal is linked, it depends on both these libraries
>>> and will fail to link if either of them is not available.
>>>
>>> This patch resolves the issue by explicitly declaring these
>>> dependencies in the confgure.ac.
>>
>> wouldn't this invalidate configure's --without-ncurses option?
> 
> No, from this point of view the patch is correct
> 
>  UL_BUILD_INIT([cal], [check])
> 
> specifies the util as optional, so
> 
>  UL_REQUIRES_HAVE([cal], [ncurses], [ncurses library])
> 
> checks for the library and if not found then print WARNING and disable
> the util. 
> 
>  UL_BUILD_INIT([cal], [yes]) 
>  
> specifies that the util is strictly required.
> 
> 
> Anyway from my point of view the patch is unnecessary as cal.c should
> be possible to compile without curses and tinfo at all.
> 
>     Karel
> 

Ok, so cal can build without ncurses and/or tinfo - fine ok.

The problem I have is with misc-utils/Makemodule.am:14

https://git.kernel.org/cgit/utils/util-linux/util-linux.git/tree/misc-utils/Makemodule.am?h=stable%2Fv2.26#n14

...this is making it link with -ltinfo, which fails because I'm not
providing it. Would it be more correct to make NCURSES_LIBS and
TINFO_LIBS become empty when they're not available? Is this how it's
meant to work? Did it ever work this way previously?

I'm slightly suspicious of my cross-build setup if configure is picking
up "-ltinfo" dependencies from the host system, but even with
'--disable-tinfo', TINFO_LIBS is still not set to "".

Also having UL_BUILD_INIT([cal], [yes]) to force cal to always be built
seem ridiculous; in fact why should any of the tools be forced? The user
should be able to mix and match whatever programs they want to have.

Another related issue is that I was hoping to be able to do
'--disable-all-programs', then '--enable-XXX' the ones I need one by one
- but the disable-all flag seems to take precedence right now.

Can someone suggest what a patch to fix this should be like?

Joel
