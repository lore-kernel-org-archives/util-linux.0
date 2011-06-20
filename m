Return-Path: util-linux-owner@vger.kernel.org
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:49343 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139Ab1FTLu2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2011 07:50:28 -0400
Subject: Re: [PATCH 2/4] uuid: implement uuid_generate_random_safe
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Theodore Tso <tytso@MIT.EDU>
In-Reply-To: <201106170937.36082.ludwig.nussel@suse.de>
Date: Mon, 20 Jun 2011 07:45:23 -0400
Cc: util-linux@vger.kernel.org
Message-Id: <68468199-43CD-4A67-80A2-4074C8870734@mit.edu>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de> <1308232779-21018-2-git-send-email-ludwig.nussel@suse.de> <20110617021517.GC29725@thunk.org> <201106170937.36082.ludwig.nussel@suse.de>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Jun 17, 2011, at 3:37 AM, Ludwig Nussel wrote:

>> 
>> Also please note that there's only *one* user of the uuid library, the
>> proprietary SAP R/3 system, that generates enough uuids, and with a
>> high enough frequency, where "safety" has ever been an issue.  Most of
>> the time, people simply aren't generating uuid's at the rate of
>> thousands a second.
> 
> I can't judge. We got quite some pressure to set the setuid bit on
> uuidd by default because 'several customers' demand it. Making the
> interface more explicitly require uuidd would defeat arguments that
> an application and the admin can't even notice there's a problem. 

Look, a time-based UUID is composed of a ethernet MAC address
(for uniqueness in space, assuming NIC's are assigned unique
MAC addresses0, a 100ns granularity timestamp (for uniqueness
in time), and a 13-bit counter. 

We are using gettimeofday(), which has microsecond granularity,
so if you have multiple calls to generate UUID's within the same
microsecond, called from different CPU's, now the only thing
protecting you is the 13-bit counter, which is initialized to a
random value w/o uuidd.   To make matters worse, the proprietary
SAP system abuses UUID's by folding, spindling, and mutilating
UUID's so the timestamp appears in the most significant bits,
so that its btree lookups (it's using the UUID's as a object id) in
the database can be as efficient as possible.  Which is why they
can't use /dev/random generated UUID's --- well, that and this
is being used in their database initialization program, where
they are generating literally millions of uuid's, and /dev/random
or some kind of scheme where you throttle time-based UUID
generation would slow down the SAP R/3 database load
process unacceptably.   (I worked with your predecessor at
SuSE/Novell, and wrote uuidd specifically because to help
out SAP, mainly because (a) I was at IBM at the time, and figured
customers of IBM hardware would care, and (b) I have one
or two friends who work at SAP, and wanted to help them out.
But I never intended for uuidd to become mandatory, and I 
got complaints from some distro's about adding yet another
daemon.)

This is why I'm pretty confident *no* *one* other than SAP is
going to be running into this problem, because I don't know of
anyone else which is generating UUID's at this insane rate ---
and would be quite, quite surprised if they were.

These days, we have a higher resolution clock interface, so at
least in theory we could use clock_gettime(), which would give
us a nanosecond interface.  This would give us another factor 
of 10 improvement on the granularity of time-based UUID's.
This might be worth doing, if someone really cared.  If they do,
though, I'd request that it be autoconf'ed, so that this library 
remains portable to non-Linux environments --- there are folks
who are using this library to build GNOME and other OSS
packages on *BSD's and Solaris systems, for example --- 
although I suspect many of them are still using the uuid library
from e2fsprogs.

-- Ted

