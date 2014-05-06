Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29166 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbaEFPbC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 11:31:02 -0400
Date: Tue, 6 May 2014 16:40:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/12] dmesg: move get_boot_time() to lib/timeutils
Message-ID: <20140506144028.GS5962@x2.net.home>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
 <201405061200.00836.sweet_f_a@gmx.de>
 <20140506112054.GP5962@x2.net.home>
 <201405061542.45205.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405061542.45205.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 06, 2014 at 03:42:44PM +0200, Ruediger Meier wrote:
> On Tuesday 06 May 2014, Karel Zak wrote:
> > On Tue, May 06, 2014 at 12:00:00PM +0200, Ruediger Meier wrote:
> 
> > > clock_gettime() needs -lrt on some systems. That's why we had
> > > dmesg_LDADD += -lrt. Now every binary which links against libcommon
> > > needs that.
> >
> >  Fixed, I have moved get_boot_time() outside libcommon.
> 
> Thanks, you still have forgotten to commit the new header
>   include/boottime.h

 Ooooh, fixed...
 
 It would be nice to have any connection between build system and git
 to avoid just stupid (but common) mistakes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
