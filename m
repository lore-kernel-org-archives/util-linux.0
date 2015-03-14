Return-Path: util-linux-owner@vger.kernel.org
Received: from mta02.eastlink.ca ([24.224.136.13]:55916 "EHLO
	mta02.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbbCNEuR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 14 Mar 2015 00:50:17 -0400
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta02.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NL600H19QOU0L11@mta02.eastlink.ca> for
 util-linux@vger.kernel.org; Sat, 14 Mar 2015 01:50:15 -0300 (ADT)
Date: Sat, 14 Mar 2015 01:50:14 -0300
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: tailf, really needed?
Message-id: <20150314045014.GO3933@cordes.ca>
References: <201503131000.29307.sweet_f_a@gmx.de>
 <5502CBFF.6090405@draigBrady.com>
In-reply-to: <5502CBFF.6090405@draigBrady.com>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 13, 2015 at 11:37:35AM +0000, Pádraig Brady wrote:
> On 13/03/15 09:00, Ruediger Meier wrote:
> > 
> > Last but not least, is anybody using tailf at all? Google does not find 
> > much about people who are using this.
>
> A deprecation warning makes sense to me.

 I haven't checked the semantics carefully, but could we just turn
tailf into a wrapper for tail -f, to avoid maintaining code that's
gotten old and crufty?  And if there aren't corner cases where someone
might still want the old tailf, until it's finally removed from
util-linux.


something like:

#!/bin/sh
if [ "$(tty <&2)" != "not a tty" ];then
    echo "warning: tailf is deprecated, and just a wrapper for tail -f" >&2
fi
exec tail -f "$@"

Or is this just asking for gratuitous breakage and confusion beyond
what any existing users will get when they upgrade to a util-linux
where it's finally dropped after a few years of deprecation?

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
