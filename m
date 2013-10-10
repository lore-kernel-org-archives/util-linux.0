Return-Path: util-linux-owner@vger.kernel.org
Received: from magister.com.au ([123.243.98.134]:37080 "EHLO magister.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754510Ab3JJAkI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Oct 2013 20:40:08 -0400
Date: Thu, 10 Oct 2013 11:39:36 +1100 (EST)
From: Craig <util-linux_contact@magister.com.au>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: ***Urgent***!  Fdisk: GPT support utterly breaks hybrid MBR;
 *must* have disable option! :(
In-Reply-To: <20131009141628.GB940@x2.net.home>
Message-ID: <alpine.LFD.2.02.1310101129260.4624@trabz.zntvfgre.pbz.nh>
References: <alpine.LFD.2.03.1310092211290.7406@aslan.magister.com.au> <20131009141628.GB940@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 9 Oct 2013, Karel Zak <kzak@redhat.com> wrote:

[...]

> It's more generic problem, we ignore MBR for hybrid GPT on more
> places (for example in kernel and libblkid).

That's fine and fair enough, but fdisk *really* does need to be able to 
bypass GPT when necessary.

> (Just for the record, hybrid GPT is ugly non-standard hack.)

Oh, I'm perfectly aware of that. :D I'm using it to force Win7 to 
dual-boot via BIOS (as opposed to UEFI) whilst having GPT partitioning for 
Linux and OSX.  Basically, GPT set up as it should be, and a hybrid MBR 
set up specifically to trick Micro$oft's garbage into booting, since it 
refuses to boot from GPT with UEFI disabled.

[...]

>    	# fdisk -l /dev/sda

>    	Disk /dev/sda: 149.1 GiB, 160041885696 bytes, 312581808 sectors
>    	Units: sectors of 1 * 512 = 512 bytes
>    	Sector size (logical/physical): 512 bytes / 512 bytes
>    	I/O size (minimum/optimal): 512 bytes / 512 bytes
>    	Disklabel type: gpt
>    	Disk identifier: 3549290F-417C-4941-8503-F7835109B821

>    	Device           Start          End   Size Type
>    	/dev/sda1         2048      2050047  1000M EFI System
>    	/dev/sda2      2050048      6146047     2G Microsoft basic data
>    	/dev/sda3      6146048     26462207   9.7G Linux swap
>    	/dev/sda4     26462208     98142207  34.2G Microsoft basic data
>    	/dev/sda5     98142208    230662143  63.2G Microsoft basic data
>    	/dev/sda6    230662144    312580095  39.1G Microsoft basic data

> but when GPT is disabled we can access PMBR:

>    	# fdisk -l -t dos /dev/sda

>    	Disk /dev/sda: 149.1 GiB, 160041885696 bytes, 312581808 sectors
>    	Units: sectors of 1 * 512 = 512 bytes
>    	Sector size (logical/physical): 512 bytes / 512 bytes
>    	I/O size (minimum/optimal): 512 bytes / 512 bytes
>    	Disklabel type: dos
>    	Disk identifier: 0x00000000

>    	Device    Boot Start       End    Blocks  Id System
>    	/dev/sda1          1 312581807 156290903+ ee GPT

Yes; _exactly_ what is needed, plus IMO a switch from within fdisk's menu 
system (Expert?) that would allow switching between GPT and MBR (or 
anything else that might be present).

Cheerio,
Craig
