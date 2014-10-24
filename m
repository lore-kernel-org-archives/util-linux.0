Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42381 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756093AbaJXLse (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 07:48:34 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 87E6820CFA
	for <util-linux@vger.kernel.org>; Fri, 24 Oct 2014 07:48:33 -0400 (EDT)
Message-Id: <1414151313.843395.182838257.3685FB42@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: JWP <elseifthen@gmx.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20141024110803.GB10134@x2.net.home>
References: <5449BD0F.2070906@gmx.com> <20141024110803.GB10134@x2.net.home>
Subject: Re: [PATCH 0/5] hwclock: clean up messages
Date: Fri, 24 Oct 2014 13:48:33 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Oct 24, 2014, at 13:08, Karel Zak wrote:
> On Thu, Oct 23, 2014 at 10:44:31PM -0400, JWP wrote:
> > This patch set cleans up various message output.
> > It contains cosmetic changes only.
> > 
> > J William Piggott (5):
> >   hwclock: Remove newline from 'date' debug output
> >   hwclock: clean up message periods/full stops
> >   hwclock: add message line breaks
> >   hwclock: Fix --date debug messages
> >   hwclock: version prints out of order
> 
> I'm going to merge these patches,

Please no.  Not the mere period and linebreak changes.

> but as a long term solution it would
> better to use include/debug.h stuff (see for example
> misc-utils/whereis.c or libmount/src/init.c).

In hwclock the "debug" messages are gettextized, because in fact
they are verbose messages to help the user understand what hwclock
is doing.  They are not meant to find programming errors in hwclock;
if that were the case, they wouldn't be gettextized, because a
programmer needs to be able to read an write English anyway.

Benno

-- 
http://www.fastmail.fm - Does exactly what it says on the tin

