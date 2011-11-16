Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10791 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab1KPNGE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 08:06:04 -0500
Date: Wed, 16 Nov 2011 14:05:51 +0100
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: Davidlohr Bueso <dave@gnu.org>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH 13/15] prlimit: enhance examples section of the man page
Message-ID: <20111116130551.GK7916@nb.net.home>
References: <4EC07381.6050608@bernhard-voelker.de> <1321267854.8015.2.camel@offworld> <7856072A9D04C24B82DFE2B1112FE38A0D86D86AB2@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0D86D86AB2@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 10:24:14AM +0100, Voelker, Bernhard wrote:
> Davidlohr Bueso wrote:
> > On Mon, 2011-11-14 at 02:48 +0100, Bernhard Voelker wrote:
> > > [PATCH 13/15] prlimit: enhance examples section of the man page
> > > 
> > > Add various examples to the man page, e.g. demonstrating setting
> > > limits using short options, showing that the --pid option can be
> > > used in random positions, how to use the "-1" notation for the
> > > "unlimited" value, and that prlimit takes the values from the arguments
> > > last set.
> 
> > Just a few examples are more than enough to illustrate the point;
> > manpages have always been this way. I think this is unnecessary and
> > clogs the document.
> 
> admitted.
> 
> Somehow I felt that the existing examples where to homogeneous.

 This is feature ;-)

 Really, we prefer nice *readable* examples with long options.

> Well, prlimit didn't e.g. support passing the PID after other
> modifying arguments, so I thought that enhancing the examples
> with the new, "wilder" usage would be nice. ;-)
> 
> But in these 2 I missed an error: there's a "=" missing between
> "--pid" and the PID:
> 
> > > -.IP "\fBprlimit \-\-pid 13134 \--rss --nofile=1024:4095\fP"
> > > +.IP "\fBprlimit \--rss \-\-pid 13134 --nofile=1024:4095\fP"
> 
> > > -.IP "\fBprlimit \-\-pid 13134 --nproc=512:\fP"
> > > +.IP "\fBprlimit \-\-pid 13134 -n512:\fP"
> 
> I only spotted the missing "=" here, but failed to mention it
> in the commit log:
> 
> > > -.IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
> > > +.IP "\fBprlimit \-\-pid=$$ --nproc=unlimited\fP"
> 
> What's your recommendation?

 The '=' is necessary for optional arguments (for example resource
 arguments) only.

 Bernhard, small note: many of your patches are malformed by your
 e-mail client. Please, reconfigure the mail client (to not modify
 long lines) or use git-send-email.

 Thanks, your found many issues!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
