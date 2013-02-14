Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19610 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934709Ab3BNPoY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Feb 2013 10:44:24 -0500
Date: Thu, 14 Feb 2013 16:44:21 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: lslocks =?utf-8?B?4oCTICJmYWlsZQ==?= =?utf-8?Q?d?= to parse pid:
 'WRITE'"
Message-ID: <20130214154421.GH19379@x2.net.home>
References: <kf0ehe$q7h$1@ger.gmane.org>
 <CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com>
 <51197D69.6050901@gmail.com>
 <20130212111248.GG20408@x2.net.home>
 <CAG27Bk109veDrkVetXg5cRSA0TogpbhJ0PwFArRyf=pqQg0zfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk109veDrkVetXg5cRSA0TogpbhJ0PwFArRyf=pqQg0zfQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 12, 2013 at 11:23:49AM +0000, Sami Kerola wrote:
> riations =E2=80=93 e.g. mandatory locks have a third type called
> >> "ACCESS", shown when a program tries to simply read/write a locked file;
> >> in this case listing the R/W mode might be more useful than "WAITING".
> >> Mandatory locks can apparently say "RW" as well, although I haven't
> >> found a way to create a "RW" lock yet.
> >
> >  Yes, IMHO we have to follow kernel and keep the original string in
> >  the MODE column.
> 
> Perhaps the columns lslocks displays by default should not be changed.
> For the blocked locks adding a small markup to MODE field such as ">"

 I have added "*", for example:

COMMAND           PID  TYPE  SIZE MODE   M      START        END PATH
flock            1318 FLOCK    0B WRITE* 0          0          0 /home/projects/

 it seems better to use postfix than prefix.

> I quite like the BLOCKED column, especially when it tells what/who is block=
> ing.

Good point.

Tomorrow I'm going to add BLOCKED-BY column with PID of the blocker.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
