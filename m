Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60795 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755451Ab2ADNhS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 Jan 2012 08:37:18 -0500
Date: Wed, 4 Jan 2012 14:37:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Dave Reisner <d@falconindy.com>, util-linux@vger.kernel.org,
        Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 1/3] column: use xalloc libs
Message-ID: <20120104133710.GC24350@x2.net.home>
References: <1324388164-2112-1-git-send-email-dreisner@archlinux.org>
 <1324390416.3316.13.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324390416.3316.13.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 20, 2011 at 03:13:36PM +0100, Davidlohr Bueso wrote:
> On Tue, 2011-12-20 at 08:36 -0500, Dave Reisner wrote:
> >  text-utils/column.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)

 Applied, thanks.

> > -	wcs = malloc((n + 1) * sizeof(wchar_t));
> > +	wcs = xmalloc((n + 1) * sizeof(wchar_t));
> >  	if (!wcs)
> >  		return NULL;
> 
> Hmm this isn't that straight forward, if the memory allocation fails
> here we don't necessarily abort the program.

 Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
