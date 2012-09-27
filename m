Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:41393 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754140Ab2I0VvM (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Sep 2012 17:51:12 -0400
Message-ID: <1348782668.2541.17.camel@offbook>
Subject: Re: [PATCH 2/3] fdisk: add GPT support
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Date: Thu, 27 Sep 2012 23:51:08 +0200
In-Reply-To: <20120927120314.GB18644@x2.net.home>
References: <1345550602.2664.6.camel@offbook>
	 <20120927120314.GB18644@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 2012-09-27 at 14:03 +0200, Karel Zak wrote:
> On Tue, Aug 21, 2012 at 02:03:22PM +0200, Davidlohr Bueso wrote:
> > This patch allows fdisk to handle GUID partition tables, based on
> > the latest UEFI specifications version 2.3.1, from June 27th, 2012.
> 
>  Applied, with some changes (add string based list of partition
>  types).

Thanks!!

> 
>  TODO:
> 
>     - differentiate between number of allocated and used partitions in GPT,
>       for example "Partition number (1-128):" dialog is strange if you have
>       only one partition. [I'll fix it tomorrow]
> 
>     - add 'Device' column to GPT list_table output [I'll fix it tomorrow]
> 
>     - add 'g' to main menu to create a new empty GPT disklabel

Yes, this is a big TODO, but fortunately it is quite straightforward
with what we have now. I'll get on it as soon as I can.

> 
>     - LBA alignment, it necessary to use the same things we use for MBR;
>       partitions has to be aligned according to I/O limits (sector
>       size). [Important!]
> 
>     - move list_table() functions to fdisk_label drive struct
> 
>     - remove 'disklabel' from fdisk.c at all and keep fdisk.c
>       independent on MBR

Yeah, this is easy yet invasive (like most initial fdisk-patches).

> 
>     - remove global label-specific variables (e.g. gpt ents[])

Do you mean this?
 static struct gpt_header *pheader = NULL;
 static struct gpt_header *bheader = NULL;
 static struct gpt_entry *ents = NULL;

If so, the reason for it being global is that it's accessed by the
fdisk_label struct members, which, as you know, callers/users cannot
know of label-specific stuff (only fdisk_context).

> 
>     - test GPT (specially 't' command) on big-endian machine
>       (EFI UUIDs has been designed during LSD trip...)

LOL. I lack the box, perhaps some good folks at Oracle/Sun can help us
with an older SPARC machine.

> 
> 
> less important things:
> 
>     - add '<something>' to fdisk menu to print details about selected
>       partition (uuid, type uuid, type name, name, etc...)
> 
>     - add '<something>' to menu to print details about the partition
>       table (header, backup header, locations, number of allocated
>       entries, used entries, offset of entry table and offset and size
>       of data area, etc.)

Perhaps in verify?

> 
> All should be implemented by drive specific functions, without
> exceptions, fdisk.c has to be simple and readable :-)

Yep, working towards that!

> 
> Note I did not applied the man page yet. I think we can do that
> later when the code will be stable.

Ok, fine by me. The manpage should be updated before the next release
though.

On another note, I am a bit concerned about dealing with writing changes
on disks with hybrid MBRs and not transforming it the standard
protective. We need to be able to do so. Any thoughts are appreciated.

- Davidlohr

