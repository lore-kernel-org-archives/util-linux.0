Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:50557 "EHLO
	homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752312Ab2IXLOZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Sep 2012 07:14:25 -0400
Message-ID: <1348485261.2456.6.camel@offbook>
Subject: Re: [PATCH 1/3] fdisk: add guid
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Date: Mon, 24 Sep 2012 13:14:21 +0200
In-Reply-To: <20120924084323.GA22639@x2.net.home>
References: <1345550594.2664.5.camel@offbook>
	 <20120921111253.GA18699@x2.net.home> <20120921130543.GA643@gnu.org>
	 <20120921143816.GB18699@x2.net.home> <20120921150450.GA21816@gnu.org>
	 <20120924082058.GA22946@x2.net.home> <20120924084323.GA22639@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2012-09-24 at 10:43 +0200, Karel Zak wrote:
> On Mon, Sep 24, 2012 at 10:20:58AM +0200, Karel Zak wrote:
> > On Fri, Sep 21, 2012 at 11:04:51AM -0400, Davidlohr Bueso wrote:
> > > On Fri, Sep 21, 2012 at 04:38:16PM +0200, Karel Zak wrote:
> > > > On Fri, Sep 21, 2012 at 09:05:43AM -0400, Davidlohr Bueso wrote:
> > > > > I honestly don't see much difference between doing it before or
> > > > > after GPT, since all the other labels need to be adapted anyway. 
> > > > 
> > > >  I see a difference. Why we need struct fdisk_guid in struct where we
> > > >  define DOS partition types? Why there is {0} everywhere?
> > > >  Do you want to remove all these changes later?
> > > 
> > > My idea of having a unique systypes structure for all labels is for simplicity.
> > > I agree, using {0} isn't the best approach, so it would obviously go out, in favor
> > > of the same one the other labels would use. So if DOS doesn't need the GUID it just
> > > won't use it (and just call ->type or ->name), but it would still be there for those 
> > > that do require it, like GPT.
> > 
> >  Maybe we can use strings.
> 
> I mean strings for UUIDs, for DOS we can keep integers there.
> 
> 
> >  struct fdisk_parttype {
> 
>       unsigned int code;
> 
> >     const char *type;           /* UUID, 0xNN, ... */
> >     const char *description;    /* help string */
> >  };

Ok, so you mean having something like this, right?:

{0x8200, "0657FD6D-A4AB-43C4-84E5-0933C84B4F4F", N_("Linux Swap")}

I see no problem decomposing the UUID string into the guid struct where
it's actually needed, in label specific functions.

> >
> >  The fdisk dialogs and menus are always based on strings and the final
> >  conversion to label specific type (int or GUID) may be done in label
> >  specific functions (like add_partition or so).
> 
> I'll try to prepare a patch... it's the best way how to explain any
> idea :-)
> 
>     Karel
> 


