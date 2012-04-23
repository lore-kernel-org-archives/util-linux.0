Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35528 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591Ab2DWKNs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 06:13:48 -0400
Date: Mon, 23 Apr 2012 12:13:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/8] fdisk: make CHS user values more robust
Message-ID: <20120423101345.GE8144@x2.net.home>
References: <1334569473.2552.10.camel@offbook>
 <20120417181903.GA8666@skipper.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120417181903.GA8666@skipper.site>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 17, 2012 at 08:19:03PM +0200, Petr Uzel wrote:
> On Mon, Apr 16, 2012 at 11:44:33AM +0200, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> > ---
> >  fdisk/cfdisk.c |    6 +++---
> >  fdisk/fdisk.c  |    8 ++++----
> >  fdisk/sfdisk.c |    9 +++++----
> >  3 files changed, 12 insertions(+), 11 deletions(-)

 Applied, thanks.

> > +		user_cylinders = cylinders = strtoll_or_err(optarg, _("cannot parse amount of cylinders"));
> 
> s/amount/number ?

 Fixed.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
