Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29511 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab1LMLqq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Dec 2011 06:46:46 -0500
Date: Tue, 13 Dec 2011 12:46:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lists: add list sorting routine
Message-ID: <20111213114642.GB22851@nb.net.home>
References: <1323730346.2536.3.camel@offbook> <1323730557.2536.5.camel@offbook> <20111213092607.GA22851@nb.net.home> <1323773786.3256.1.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323773786.3256.1.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 13, 2011 at 11:56:26AM +0100, Davidlohr Bueso wrote:
> On Tue, 2011-12-13 at 10:26 +0100, Karel Zak wrote:
> > On Mon, Dec 12, 2011 at 11:55:57PM +0100, Davidlohr Bueso wrote:
> > > One note: the code is added to the header file instead of its own C file
> > > so we don't have to update all the build rules of the list.h users.
> > 
> > [...]
> > 
> > > > +static struct list_head *merge(int (*cmp)(struct list_head *a,
> > > > +					  struct list_head *b),
> > > > +			       struct list_head *a, struct list_head *b)
> > 
> >  shouldn't be the function "static inline" (or _INLINE_ ) ?
> 
> Hmm yes, do you want me to send another patch with the correction?

No, I'll fix it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
