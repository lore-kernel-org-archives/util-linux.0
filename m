Return-Path: util-linux-owner@vger.kernel.org
Received: from fencepost.gnu.org ([208.118.235.10]:60378 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903Ab2IUPEw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 21 Sep 2012 11:04:52 -0400
Date: Fri, 21 Sep 2012 11:04:51 -0400
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] fdisk: add guid
Message-ID: <20120921150450.GA21816@gnu.org>
References: <1345550594.2664.5.camel@offbook>
 <20120921111253.GA18699@x2.net.home>
 <20120921130543.GA643@gnu.org>
 <20120921143816.GB18699@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120921143816.GB18699@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 21, 2012 at 04:38:16PM +0200, Karel Zak wrote:
> On Fri, Sep 21, 2012 at 09:05:43AM -0400, Davidlohr Bueso wrote:
> > I honestly don't see much difference between doing it before or
> > after GPT, since all the other labels need to be adapted anyway. 
> 
>  I see a difference. Why we need struct fdisk_guid in struct where we
>  define DOS partition types? Why there is {0} everywhere?
>  Do you want to remove all these changes later?

My idea of having a unique systypes structure for all labels is for simplicity.
I agree, using {0} isn't the best approach, so it would obviously go out, in favor
of the same one the other labels would use. So if DOS doesn't need the GUID it just
won't use it (and just call ->type or ->name), but it would still be there for those 
that do require it, like GPT.

> 
>  Anyway, I have no problem to write the patch to split part types to
>  separate per-label tables :-)

Me neither, I can easly do it and rebase the GPT patch afterwards. I just really
want us all to agree on how we're going to go about this.

> 
>  It also seems that you're introduce a new hex codes for GPT partition
>  types. It means that you want to use int16_t to address types defined
>  by UUIDs.  Is it good idea? Would be better to address the types by
>  numbers <1-N> as printed in the menu or directly by UUIDs?

True, 1 through N is probably better - I'll look into it. In any case I don't
see why we're showing the user (ie: 'l' menu option) hex values, we could easily
just show decimal and any number for any partition type. Perhaps I'm missing something
about standards, but I clearly remember certain values types, like 'Linux swap' to always
be specified by value 82 (hex), which we can see defined in fdisk.h.

So would it be ok to be able to change these values if needed?

Thanks.
