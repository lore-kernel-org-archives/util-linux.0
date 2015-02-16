Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38999 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbbBPK1a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Feb 2015 05:27:30 -0500
Date: Mon, 16 Feb 2015 11:27:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: libsmartcols patch
Message-ID: <20150216102726.GH11948@ws.net.home>
References: <54A0AE98.70503@ubuntu.com>
 <20150216050053.GA4075@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150216050053.GA4075@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 16, 2015 at 12:00:53AM -0500, Mike Frysinger wrote:
> On 28 Dec 2014 20:30, Phillip Susi wrote:
> > --- libsmartcols/src/table_print.c	2014-12-24 23:59:55.780110296 +0200
> > +++ libsmartcols/src/table_print.c	2014-12-28 22:45:20.347285226 +0200
> >  
> > +	assert(ln);
> > +	assert(buf);
> 
> general note: libraries should never assert/abort/exit.

 what about segfault?
 
 We use assert to detect fatal internal library bugs, for mistakes in
 applications (e.g. incomplete arguments) it returns -EINVAL.

 Its' possible to remove CONFIG_LIBSMARTCOLS_ASSERT from smartcolsP.h,
 but I don't think the library is already well tested.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
