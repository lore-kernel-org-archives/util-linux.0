Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42737 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbbGXH4O (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jul 2015 03:56:14 -0400
Date: Fri, 24 Jul 2015 09:56:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Joel Holdsworth <joel.holdsworth@vcatechnology.com>,
        util-linux@vger.kernel.org, Joel Holdsworth <joel@airwebreathe.org.uk>
Subject: Re: [PATCH] build-sys: cal requires both ncurses and tinfo
Message-ID: <20150724075612.GE3432@ws.net.home>
References: <1437692199-7557-1-git-send-email-joel.holdsworth@vcatechnology.com>
 <55B1D9F7.4040109@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B1D9F7.4040109@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 24, 2015 at 08:23:51AM +0200, Bernhard Voelker wrote:
> On 07/24/2015 12:56 AM, Joel Holdsworth wrote:
> > This fixes a bug in the build system when building without ncurses
> > and tinfo. When cal is linked, it depends on both these libraries
> > and will fail to link if either of them is not available.
> > 
> > This patch resolves the issue by explicitly declaring these
> > dependencies in the confgure.ac.
> 
> wouldn't this invalidate configure's --without-ncurses option?

No, from this point of view the patch is correct

 UL_BUILD_INIT([cal], [check])

specifies the util as optional, so

 UL_REQUIRES_HAVE([cal], [ncurses], [ncurses library])

checks for the library and if not found then print WARNING and disable
the util. 

 UL_BUILD_INIT([cal], [yes]) 
 
specifies that the util is strictly required.


Anyway from my point of view the patch is unnecessary as cal.c should
be possible to compile without curses and tinfo at all.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
