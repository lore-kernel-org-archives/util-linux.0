Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59784 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755245Ab2IXIVH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Sep 2012 04:21:07 -0400
Date: Mon, 24 Sep 2012 10:20:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] fdisk: add guid
Message-ID: <20120924082058.GA22946@x2.net.home>
References: <1345550594.2664.5.camel@offbook>
 <20120921111253.GA18699@x2.net.home>
 <20120921130543.GA643@gnu.org>
 <20120921143816.GB18699@x2.net.home>
 <20120921150450.GA21816@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120921150450.GA21816@gnu.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 21, 2012 at 11:04:51AM -0400, Davidlohr Bueso wrote:
> On Fri, Sep 21, 2012 at 04:38:16PM +0200, Karel Zak wrote:
> > On Fri, Sep 21, 2012 at 09:05:43AM -0400, Davidlohr Bueso wrote:
> > > I honestly don't see much difference between doing it before or
> > > after GPT, since all the other labels need to be adapted anyway. 
> > 
> >  I see a difference. Why we need struct fdisk_guid in struct where we
> >  define DOS partition types? Why there is {0} everywhere?
> >  Do you want to remove all these changes later?
> 
> My idea of having a unique systypes structure for all labels is for simplicity.
> I agree, using {0} isn't the best approach, so it would obviously go out, in favor
> of the same one the other labels would use. So if DOS doesn't need the GUID it just
> won't use it (and just call ->type or ->name), but it would still be there for those 
> that do require it, like GPT.

 Maybe we can use strings.

 struct fdisk_parttype {
    const char *type;           /* UUID, 0xNN, ... */
    const char *description;    /* help string */
 };

 The fdisk dialogs and menus are always based on strings and the final
 conversion to label specific type (int or GUID) may be done in label
 specific functions (like add_partition or so).

> >  It also seems that you're introduce a new hex codes for GPT partition
> >  types. It means that you want to use int16_t to address types defined
> >  by UUIDs.  Is it good idea? Would be better to address the types by
> >  numbers <1-N> as printed in the menu or directly by UUIDs?
> 
> True, 1 through N is probably better - I'll look into it. In any case I don't
> see why we're showing the user (ie: 'l' menu option) hex values, we could easily
> just show decimal and any number for any partition type. Perhaps I'm missing something
> about standards, but I clearly remember certain values types, like 'Linux swap' to always
> be specified by value 82 (hex), which we can see defined in fdisk.h.
> 
> So would it be ok to be able to change these values if needed?

 We have to support the real values for backward compatibility and for
 extendability -- it should be possible to specify arbitrary
 UUID. I think the best is to support the both ways

    - index value <1-N>
    - real values (hex for DOS, strings for Mac, UUID for GPT, ...)

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
