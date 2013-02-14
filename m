Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310Ab3BNPCO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Feb 2013 10:02:14 -0500
Date: Thu, 14 Feb 2013 16:02:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: kerolasa@gmail.com, Sami Kerola <kerolasa@iki.fi>,
        Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: lslocks =?utf-8?B?4oCTICJmYWlsZQ==?= =?utf-8?Q?d?= to parse pid:
 'WRITE'"
Message-ID: <20130214150200.GG19379@x2.net.home>
References: <kf0ehe$q7h$1@ger.gmane.org>
 <CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com>
 <51197D69.6050901@gmail.com>
 <20130212111248.GG20408@x2.net.home>
 <CAG27Bk109veDrkVetXg5cRSA0TogpbhJ0PwFArRyf=pqQg0zfQ@mail.gmail.com>
 <511A2DDA.40504@bernhard-voelker.de>
 <20130212131830.GA18597@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130212131830.GA18597@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 12, 2013 at 02:18:30PM +0100, Karel Zak wrote:
> On Tue, Feb 12, 2013 at 12:56:10PM +0100, Bernhard Voelker wrote:
> > On 02/12/2013 12:23 PM, Sami Kerola wrote:
> > > Almost off topic.
> > 
> > while we're at it - ;-)
> > is it necessary to open/read/close "/proc/self/mountinfo" so often?
> > 
> >   $ strace -e open ./lslocks 2>&1 | grep mountinfo | wc -l
> >   67
> 
> especially when we have libmount in the same source tree :-) Just use
> mnt_new_table_from_file(_PATH_PROC_MOUNTINFO) and keep the pointer...

Fixed.

$ strace -e open ./lslocks 2>&1 | grep mountinfo | wc -l
1

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
