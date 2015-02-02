Return-Path: peter@cordes.ca
Date: Mon, 02 Feb 2015 08:49:25 -0400
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk's input fields behave awkwardly (in utf8 locale)
Message-id: <20150202124925.GC3933@cordes.ca>
References: <1422799326.1853638.221575473.7DCCA1B0@webmail.messagingengine.com>
 <20150202121126.GL16162@ws.net.home> <20150202122923.GA3933@cordes.ca>
 <20150202123736.GN16162@ws.net.home>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <20150202123736.GN16162@ws.net.home>
From: Peter Cordes <peter@cordes.ca>
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 02, 2015 at 01:37:36PM +0100, Karel Zak wrote:
> On Mon, Feb 02, 2015 at 08:29:23AM -0400, Peter Cordes wrote:
> >
> >  Maybe link with GNU readline, to avoid reinventing the wheel.
> 
> yep, and maybe for all fdisks, but it would be probably nice to have
> it optional (--with-readline), and without readline keep it simple and
> stupid.

 Yeah, I think that's the behaviour I've seen from other packages.
When built without readline, they just leave the tty in cooked mode,
so a line of input becomes read(2)able when the user presses return.

 I guess cfdisk already has an arrow-key driven UI, so the wrapper
for readline (that compiles to a fallback #ifndef HAVE_READLINE) would
have to put the tty in/out of cooked mode.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
