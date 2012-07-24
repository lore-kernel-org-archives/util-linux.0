Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaid.dreamhost.com ([208.97.132.83]:46501 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752162Ab2GXLcs (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 07:32:48 -0400
Subject: Re: [PATCH 02/10] fdisk: API: add to label operations to context
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120724112217.GB7057@x2.net.home>
References: <1342976701.2863.12.camel@offbook>
	 <20120724094131.GB2086@foxbat.suse.cz>  <20120724112217.GB7057@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Jul 2012 13:32:45 +0200
Message-ID: <1343129565.2686.14.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2012-07-24 at 13:22 +0200, Karel Zak wrote:
> On Tue, Jul 24, 2012 at 11:41:31AM +0200, Petr Uzel wrote:
> > On Sun, Jul 22, 2012 at 07:05:01PM +0200, Davidlohr Bueso wrote:
> > > From: Davidlohr Bueso <dave@gnu.org>
> > > 
> > > The context structure is the fdisk API's main data type as it keeps all data together. Add the
> > > label structure to it, so that the pt-specific operations can be called from the context.
> 
>  Applied with changes, thanks.
> 
> > > The internal probing function is updated so that if a label is not probed, for example when a
> > > disk is not formated, it will default to use either sun or dos label operations. This avoids
> 
>  This is not so simple. You have to apply geometry and another
>  settings (sector size, ...) from user *before* you create a new disk
>  label.  (See the original code, get_boot() and get_geometry()
>  functions.)

Hmm, well the original get_boot() did most of the work that
fdisk_new_context_from_filename() currently does - thanks for getting
rid of it BTW :) Since label probing is the last action taken in this
function, wouldn't everything be set already? Perhaps I'm missing
something.

> 
>  It means that we should not create any default disklabel in
>  fdisk_new_context_from_filename(). I think it will be better to make
>  the API less complex and split this task into two steps:
> 
>     cxt = fdisk_new_context_from_filename(devname, 0);
> 
>     /* --- here apply your setting to the new context -- */
> 
>     if (!fdisk_dev_has_disklabel(cxt))
>         fdisk_create_disklabel(cxt, NULL);      /* NULL means default */
> 
> 
>  It should be our common rule that the API is well fragmented to small
>  usable functions.

Ok, I was trying to make it easier for users by doing most of the work
when calling fdisk_new_context_from_filename() - you're right about
loosing flexibility though.

> 
>  Maybe one day we will create
> 
>      fdisk_new_context()
>      fdisk_context_assign_device()
> 
>  because the current fdisk_new_context_from_filename() is already too
>  complex for some scenarios -- for example if you want to add some
>  callbacks to the context.  We will see ;-)

Good point, I agree.

Thanks for reviewing!
Davidlohr

