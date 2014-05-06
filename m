Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:58988 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758013AbaEFQDt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 12:03:49 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 02/12] dmesg: move get_boot_time() to lib/timeutils
Date: Tue, 6 May 2014 18:03:46 +0200
Cc: util-linux@vger.kernel.org
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi> <201405061542.45205.sweet_f_a@gmx.de> <20140506144028.GS5962@x2.net.home>
In-Reply-To: <20140506144028.GS5962@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405061803.46452.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 06 May 2014, Karel Zak wrote:
> On Tue, May 06, 2014 at 03:42:44PM +0200, Ruediger Meier wrote:
> > On Tuesday 06 May 2014, Karel Zak wrote:
> > > On Tue, May 06, 2014 at 12:00:00PM +0200, Ruediger Meier wrote:
> > > > clock_gettime() needs -lrt on some systems. That's why we had
> > > > dmesg_LDADD += -lrt. Now every binary which links against
> > > > libcommon needs that.
> > >
> > >  Fixed, I have moved get_boot_time() outside libcommon.
> >
> > Thanks, you still have forgotten to commit the new header
> >   include/boottime.h
>
>  Ooooh, fixed...
>
>  It would be nice to have any connection between build system and git
>  to avoid just stupid (but common) mistakes.

We have "make distcheck" and because it's annoying to do this manually 
before any push there is "travis" to get it done automatically at least 
a few minutes after.

I had ask you once if you could sign up and enable travis, see
https://github.com/karelzak/util-linux/pull/65
Would be really nice to have it.

BTW bootime.c is still missing ;)

cu,
Rudi
