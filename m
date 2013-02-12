Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62101 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932303Ab3BLLNA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Feb 2013 06:13:00 -0500
Date: Tue, 12 Feb 2013 12:12:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Cc: kerolasa@gmail.com, Sami Kerola <kerolasa@iki.fi>,
        util-linux@vger.kernel.org
Subject: Re: lslocks =?utf-8?B?4oCTICJmYWlsZQ==?= =?utf-8?Q?d?= to parse pid:
 'WRITE'"
Message-ID: <20130212111248.GG20408@x2.net.home>
References: <kf0ehe$q7h$1@ger.gmane.org>
 <CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com>
 <51197D69.6050901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51197D69.6050901@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 12, 2013 at 01:23:21AM +0200, Mantas Mikulėnas wrote:
> On 2013-02-12 00:42, Sami Kerola wrote:
> > Karel, and others, what do you think about adding a mode
> > to output listing which some might say is not a mode at all?
> 
> Just tested the patch and it works here, but wouldn't it be better to
> add a "waiting" flag to the mode display, or something like that?
> ("WAIT-READ" and "WAIT-WRITE"?)
> 
> 
> 
> Side note: It seems that fs/locks.c:lock_get_status can output many
> other variations – e.g. mandatory locks have a third type called
> "ACCESS", shown when a program tries to simply read/write a locked file;
> in this case listing the R/W mode might be more useful than "WAITING".
> Mandatory locks can apparently say "RW" as well, although I haven't
> found a way to create a "RW" lock yet.

 Yes, IMHO we have to follow kernel and keep the original string in
 the MODE column.

> Also, while I haven't yet seen this in practice either, the same
> fs/locks.c can output lock type "LEASE", which has completely different
> values for the 3rd field, and cannot be represented by a binary
> "M[andatory] = 0/1" column.

 Good point. This should be fixed. I think that lease locks could be
 also interpreted as mandatory (so "1" should be used in "M" column). 
 
 But you're right that we need something more to describe lease locks
 -- probably by another column "PROCMODE" (process mode) and use
 keywords BREAKING, ACTIVE and BREAKER from kernel.  
 
 Maybe we can use the same column to identify blocked flock/posix
 processes (by BLOCKED keyword) as I described in my previous email.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
