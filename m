Return-Path: peter@cordes.ca
Date: Mon, 02 Feb 2015 08:29:23 -0400
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk's input fields behave awkwardly (in utf8 locale)
Message-id: <20150202122923.GA3933@cordes.ca>
References: <1422799326.1853638.221575473.7DCCA1B0@webmail.messagingengine.com>
 <20150202121126.GL16162@ws.net.home>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <20150202121126.GL16162@ws.net.home>
From: Peter Cordes <peter@cordes.ca>
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 02, 2015 at 01:11:26PM +0100, Karel Zak wrote:
> On Sun, Feb 01, 2015 at 03:02:06PM +0100, Benno Schulenberg wrote:
> > [...cfdisk...]
> > prompted for a partition size, would put the cursor at the start
> > of the suggested value, and hitting any other key than Enter
> > would erase this value. That is nice and desirable behaviour.
> > Could that be restored?
> 
>  It would be better to implement full one line editor with support for
>  all basic keys and with ability to insert and erase chars on
>  arbitrary position with in the string... v2.27 :-)

 Maybe link with GNU readline, to avoid reinventing the wheel.


-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
