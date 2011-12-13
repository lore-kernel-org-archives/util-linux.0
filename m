Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30742 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab1LMJ0K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Dec 2011 04:26:10 -0500
Date: Tue, 13 Dec 2011 10:26:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lists: add list sorting routine
Message-ID: <20111213092607.GA22851@nb.net.home>
References: <1323730346.2536.3.camel@offbook> <1323730557.2536.5.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323730557.2536.5.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 12, 2011 at 11:55:57PM +0100, Davidlohr Bueso wrote:
> One note: the code is added to the header file instead of its own C file
> so we don't have to update all the build rules of the list.h users.

[...]

> > +static struct list_head *merge(int (*cmp)(struct list_head *a,
> > +					  struct list_head *b),
> > +			       struct list_head *a, struct list_head *b)

 shouldn't be the function "static inline" (or _INLINE_ ) ?


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
