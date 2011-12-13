Return-Path: dave@gnu.org
Subject: Re: [PATCH] lists: add list sorting routine
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20111213092607.GA22851@nb.net.home>
References: <1323730346.2536.3.camel@offbook>
	 <1323730557.2536.5.camel@offbook>  <20111213092607.GA22851@nb.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Dec 2011 11:56:26 +0100
Message-ID: <1323773786.3256.1.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Tue, 2011-12-13 at 10:26 +0100, Karel Zak wrote:
> On Mon, Dec 12, 2011 at 11:55:57PM +0100, Davidlohr Bueso wrote:
> > One note: the code is added to the header file instead of its own C file
> > so we don't have to update all the build rules of the list.h users.
> 
> [...]
> 
> > > +static struct list_head *merge(int (*cmp)(struct list_head *a,
> > > +					  struct list_head *b),
> > > +			       struct list_head *a, struct list_head *b)
> 
>  shouldn't be the function "static inline" (or _INLINE_ ) ?

Hmm yes, do you want me to send another patch with the correction?
