Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:45134 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753818Ab1KNJYR convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 04:24:17 -0500
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Davidlohr Bueso <dave@gnu.org>,
        Bernhard Voelker <mail@bernhard-voelker.de>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Mon, 14 Nov 2011 10:24:14 +0100
Subject: RE: [PATCH 13/15] prlimit: enhance examples section of the man page
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D86D86AB2@MCHP058A.global-ad.net>
References: <4EC07381.6050608@bernhard-voelker.de>
 <1321267854.8015.2.camel@offworld>
In-Reply-To: <1321267854.8015.2.camel@offworld>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Davidlohr Bueso wrote:
> On Mon, 2011-11-14 at 02:48 +0100, Bernhard Voelker wrote:
> > [PATCH 13/15] prlimit: enhance examples section of the man page
> > 
> > Add various examples to the man page, e.g. demonstrating setting
> > limits using short options, showing that the --pid option can be
> > used in random positions, how to use the "-1" notation for the
> > "unlimited" value, and that prlimit takes the values from the arguments
> > last set.

> Just a few examples are more than enough to illustrate the point;
> manpages have always been this way. I think this is unnecessary and
> clogs the document.

admitted.

Somehow I felt that the existing examples where to homogeneous.
Well, prlimit didn't e.g. support passing the PID after other
modifying arguments, so I thought that enhancing the examples
with the new, "wilder" usage would be nice. ;-)

But in these 2 I missed an error: there's a "=" missing between
"--pid" and the PID:

> > -.IP "\fBprlimit \-\-pid 13134 \--rss --nofile=1024:4095\fP"
> > +.IP "\fBprlimit \--rss \-\-pid 13134 --nofile=1024:4095\fP"

> > -.IP "\fBprlimit \-\-pid 13134 --nproc=512:\fP"
> > +.IP "\fBprlimit \-\-pid 13134 -n512:\fP"

I only spotted the missing "=" here, but failed to mention it
in the commit log:

> > -.IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
> > +.IP "\fBprlimit \-\-pid=$$ --nproc=unlimited\fP"

What's your recommendation?

Have a nice day,
Berny