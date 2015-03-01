Return-Path: peter@cordes.ca
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Date: Sun, 01 Mar 2015 11:14:40 -0400
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Karel Zak <kzak@redhat.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>, kerolasa@gmail.com,
        "Dale R. Worley" <worley@alum.mit.edu>, mrmazda@earthlink.net,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-id: <20150301151440.GV3933@cordes.ca>
References: <20150213092131.GM32318@ws.net.home>
 <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com>
 <20150213112523.GP32318@ws.net.home> <20150215111238.GG32251@vapier>
 <20150216091043.GA11948@ws.net.home> <20150216093533.GJ4075@vapier>
 <20150216094747.GC11948@ws.net.home>
 <20150216103241.GD3926@type.bordeaux.inria.fr>
 <20150227134805.GB8046@ws.net.home> <54F314D1.2080003@draigBrady.com>
In-reply-to: <54F314D1.2080003@draigBrady.com>
From: Peter Cordes <peter@cordes.ca>
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 01, 2015 at 01:32:01PM +0000, Pádraig Brady wrote:
> On 27/02/15 13:48, Karel Zak wrote:
> >  This is not implemented yet, I (or any volunteer?) will try to add to code 
> >  an extra layer to avoid the hardcoded sequences and read the colors from terminfo.
> 
> I'd be careful to not over engineer that.
> coreutils currently hardcodes ansi sequences,
> and I've not heard specific complaints about it.
> What terminals are not catered for here?

 At this point, it's hard to imagine anyone writing a new terminal
emulator with incompatible color escape sequences.

 Anyone on really rare hardware terminals or crufty software that is
different for some reason can always disable colors for software that
hard-codes sequences.  They're nice but non-essential.

 The only scenario I'm coming up with where it would be really good to
use a library to find what escape sequences to use would be
future-proofing against the day when somebody extends the ANSI color
escape sequences to support more colors, or 3D for stereoscopic-vision
terminals.  And even then, only if for some reason they choose to
extend the escape sequences in a non-backwards-compat way.

 I'd hold off on spending time on this until some new idea
for color escape codes comes along.  I think there's enough inertia
behind the current ANSI escape sequences that terminal emulators will
need to support current-style escape sequences for decades after the
appearance of a new way of doing things.  I think decades is long
enough for util-linux to make this proposed change and have it
percolate into long-term-support releases before any terminal
emulators think they can get away with dropping support for
current-style color escape sequences.

 Anyway, that's my 2 cents.  I'd maybe change my mind if anyone has a
real-life case where the hardcoded ANSI codes don't work for them, on
a terminal they actually want to use, but terminfo would.  (I'm not
talking about ancient cruft you can find that's incompat, but rather
stuff people actually do use regularly.)

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
