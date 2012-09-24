Return-Path: dave@gnu.org
Message-ID: <1348485380.2456.8.camel@offbook>
Subject: Re: [PATCH 1/3] fdisk: add guid
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Date: Mon, 24 Sep 2012 13:16:20 +0200
In-Reply-To: <20120924082058.GA22946@x2.net.home>
References: <1345550594.2664.5.camel@offbook>
	 <20120921111253.GA18699@x2.net.home> <20120921130543.GA643@gnu.org>
	 <20120921143816.GB18699@x2.net.home> <20120921150450.GA21816@gnu.org>
	 <20120924082058.GA22946@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Mon, 2012-09-24 at 10:20 +0200, Karel Zak wrote:
> On Fri, Sep 21, 2012 at 11:04:51AM -0400, Davidlohr Bueso wrote:
> > On Fri, Sep 21, 2012 at 04:38:16PM +0200, Karel Zak wrote:
> > > On Fri, Sep 21, 2012 at 09:05:43AM -0400, Davidlohr Bueso wrote:
> > > > I honestly don't see much difference between doing it before or
> > > > after GPT, since all the other labels need to be adapted anyway. 
> > > 
> > >  I see a difference. Why we need struct fdisk_guid in struct where we
> > >  define DOS partition types? Why there is {0} everywhere?
> > >  Do you want to remove all these changes later?
> > 
> > My idea of having a unique systypes structure for all labels is for simplicity.
> > I agree, using {0} isn't the best approach, so it would obviously go out, in favor
> > of the same one the other labels would use. So if DOS doesn't need the GUID it just
> > won't use it (and just call ->type or ->name), but it would still be there for those 
> > that do require it, like GPT.
> 
>  Maybe we can use strings.
> 
>  struct fdisk_parttype {
>     const char *type;           /* UUID, 0xNN, ... */
>     const char *description;    /* help string */
>  };
> 
>  The fdisk dialogs and menus are always based on strings and the final
>  conversion to label specific type (int or GUID) may be done in label
>  specific functions (like add_partition or so).
> 
> > >  It also seems that you're introduce a new hex codes for GPT partition
> > >  types. It means that you want to use int16_t to address types defined
> > >  by UUIDs.  Is it good idea? Would be better to address the types by
> > >  numbers <1-N> as printed in the menu or directly by UUIDs?
> > 
> > True, 1 through N is probably better - I'll look into it. In any case I don't
> > see why we're showing the user (ie: 'l' menu option) hex values, we could easily
> > just show decimal and any number for any partition type. Perhaps I'm missing something
> > about standards, but I clearly remember certain values types, like 'Linux swap' to always
> > be specified by value 82 (hex), which we can see defined in fdisk.h.
> > 
> > So would it be ok to be able to change these values if needed?
> 
>  We have to support the real values for backward compatibility and for
>  extendability -- it should be possible to specify arbitrary
>  UUID. I think the best is to support the both ways
> 
>     - index value <1-N>
>     - real values (hex for DOS, strings for Mac, UUID for GPT, ...)
> 

Ok, I'm a little lost here. What I'm referring to is what we present to
the user for choosing a partition type. Currently we only use hex
values. I don't think we should bother the user with UUIDs here. Maybe
I'm just misreading this.

Thanks.
