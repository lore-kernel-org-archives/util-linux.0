Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55423 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbcETK1d (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 May 2016 06:27:33 -0400
Date: Fri, 20 May 2016 12:27:31 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: cal: bug on FreeBSD
Message-ID: <20160520102731.schhho5sl6k7cwq3@ws.net.home>
References: <201603081437.31966.sweet_f_a@gmx.de>
 <CAG27Bk02Yx5fxpV0sWGaLF7W4jSVOcKwGXWQBBQ7DLT48kZF8w@mail.gmail.com>
 <201603082359.43056.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201603082359.43056.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 08, 2016 at 11:59:43PM +0100, Rüdiger Meier wrote:
> On Tuesday 08 March 2016 23:35:01 Sami Kerola wrote:
> > Does this happen with putp() only? The following should enable you to
> > test the fputs() output.
> 
> It's only broken with putp, I tried it like this

It's BSD specific problem, putp (aka tputs) interprets the string.
That's fine as tputs is sensitive to sequences prefixed by $< and
everything else is printed to terminal. 

BUT probably because BSD has origins in 70' LSD era there is a
special exception (ncurses sources tinfo/lib_tputs.c):

    #if BSD_TPUTS
       /*
        * This ugly kluge deals with the fact that some ancient BSD
        * programs (like nethack) actually do the likes of tputs("50") to
        * get delays.
        */
        if (isdigit(UChar(*string))) {
        ...
        }
    #endif

and the number is interpreted as argument for delay_output() and never
printed to the output.

It seems we're little bit fragile with putp() as it's primarily
designed for terminfo string variables than for a generic output.
Unfortunately mix tputs() and fputs() is also no perfect due to
buffering issues (commit 07ac4aa9d4f36a6618fd3ab1423bc33e3903ddbd).

The easy fix is to disable ncurses support for BSD (words like fuck
and suck are allowed in the commit message for this case:-).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
