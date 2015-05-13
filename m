Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933657AbbEMLQ3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 May 2015 07:16:29 -0400
Date: Wed, 13 May 2015 13:16:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Michael Marineau <michael.marineau@coreos.com>
Subject: Re: [PATCH] libfdisk: (gpt) fix attributes endianess
Message-ID: <20150513111626.GF4834@ws.net.home>
References: <1431085193-1509-1-git-send-email-sweet_f_a@gmx.de>
 <201505120847.40612.sweet_f_a@gmx.de>
 <20150513091700.GC4834@ws.net.home>
 <201505131158.06032.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201505131158.06032.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 13, 2015 at 11:58:05AM +0200, Ruediger Meier wrote:
> On Wednesday 13 May 2015, Karel Zak wrote:
> > On Tue, May 12, 2015 at 08:47:40AM +0200, Ruediger Meier wrote:
> > > On Monday 11 May 2015, Karel Zak wrote:
> > > > On Fri, May 08, 2015 at 01:39:53PM +0200, Ruediger Meier wrote:
> > > > > The new libfdisk/gpt test (4a4a0927) discovered that we read
> > > > > and write partition attributes wrongly on BE systems.
> > > >
> > > > It was pretty hidden bug (as the problem was in the both set/get
> > > > functions).
> > >
> > > BTW maybe we could add the new raw attributes interface to sfdisk
> > > too. Like
> > > $ ./sfdisk --part-attrs img 1 "0x0000000000000001"
> > > (and also for stdin text input)
> > >
> > > This would make sfdisk forward compatible (in case they invent new
> > > attributes) and we could remove test_fdisk_gpt helper again.
> >
> >  Send patch :-)
> 
> Ok, but still two questions.
> 
> 1.
> Like the example above I'd like to simply interprete hex numbers as 
> bitsets. But because of strtol() hex numbers are working already now. 
> This does the same:
> $ ./sfdisk --part-attrs img 1 "56"
> $ ./sfdisk --part-attrs img 1 "0x38"
> 
> I guess nobody ever used hexnumbers for GUID so far but the dumps from 
> the future sfdisk would behave strange with sfdisk-2.26. So should we 
> use a new prefix "bitset:0x..." or "raw:0x..."? 

We nowhere use hex numbers now (and frankly --part-attrs img "0x38" is
side-effect of strtol() rather than planned behavior :-) and for dumps
and another outputs we use gpt_entry_attrs_to_string() where is also no
hex numbers, but list of bits.

IMHO it would be better to detect 0x prefix in gpt_entry_attrs_from_string() 
and if specified than use the number as new attribute rather than toggle 
individual bits. 

And mix normal numbers and hex number should be forbidden. It means
that the string for gpt_entry_attrs_from_string() should be:

 <ATTR-STR> : <HEX>|<LIST>

 <LIST> : <NAME>|<NUM> [, ...]
 <HEX>  : "0x"

where <LIST> toggle individual bits, and <HEX> replaces all attribute.

In all cases we need to verify that final attribute number is
compatible with EFI standard (see below). It would be probably good to
add gpt_verify_attrs() and use it also in
fdisk_gpt_set_partition_attrs().

> 2.
> Rather than suporting whole bitsets only we could simply allow "any bit" 
> to let this just work:
> $ ./sfdisk --part-attrs img 1 "23"
> unsupported GPT attribute bit '23'

That's question, EFI standard specifies that only bits in range 48..64
are "free" and maybe used for arbitrary purpose. The rest is owned by
standard (and currently standard uses first three bits only). So I
think it's fine that you cannot toggle bit "23".

The code in gpt_entry_attrs_from_string() allows to address by numbers
only the "free" bits. This is probably too restrictive, it should be
also possible to address EFI standard bits (RequiredPartiton,
NoBlockIOProtocol and LegacyBIOSBootable) by numbers.

The new API fdisk_gpt_set_partition_attrs() seems pretty open and
allows to set arbitrary bits, maybe it should be more restrictive to
keep unused standard bits unmodified.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
