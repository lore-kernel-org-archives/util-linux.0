Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19427 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756240AbaJXMSf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 08:18:35 -0400
Date: Fri, 24 Oct 2014 14:18:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: JWP <elseifthen@gmx.com>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/5] hwclock: clean up messages
Message-ID: <20141024121825.GC10134@x2.net.home>
References: <5449BD0F.2070906@gmx.com>
 <20141024110803.GB10134@x2.net.home>
 <1414151313.843395.182838257.3685FB42@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414151313.843395.182838257.3685FB42@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 24, 2014 at 01:48:33PM +0200, Benno Schulenberg wrote:
> 
> On Fri, Oct 24, 2014, at 13:08, Karel Zak wrote:
> > On Thu, Oct 23, 2014 at 10:44:31PM -0400, JWP wrote:
> > > This patch set cleans up various message output.
> > > It contains cosmetic changes only.
> > > 
> > > J William Piggott (5):
> > >   hwclock: Remove newline from 'date' debug output
> > >   hwclock: clean up message periods/full stops
> > >   hwclock: add message line breaks
> > >   hwclock: Fix --date debug messages
> > >   hwclock: version prints out of order
> > 
> > I'm going to merge these patches,
> 
> Please no.  Not the mere period and linebreak changes.

 Thanks for review, that's reason why I usually wait at least a day..
 :-)

> > but as a long term solution it would
> > better to use include/debug.h stuff (see for example
> > misc-utils/whereis.c or libmount/src/init.c).
> 
> In hwclock the "debug" messages are gettextized, because in fact

 ah..

> they are verbose messages to help the user understand what hwclock
> is doing.  They are not meant to find programming errors in hwclock;
> if that were the case, they wouldn't be gettextized, because a
> programmer needs to be able to read an write English anyway.

 Good point, then it would be better to keen --debug independent on
 HWCLOCK_DEBUG=. 
 
 But I still think that for so complex tool like hwclock we need a 
 real debug output for developers / bug reporters.  The current --debug 
 is more like --verbose we have in another tools.

    Larel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
