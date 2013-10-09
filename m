Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3559 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322Ab3JIOQg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Oct 2013 10:16:36 -0400
Date: Wed, 9 Oct 2013 16:16:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Craig <util-linux_contact@magister.com.au>
Cc: util-linux@vger.kernel.org
Subject: Re: ***Urgent***!  Fdisk: GPT support utterly breaks hybrid MBR;
 *must* have disable option! :(
Message-ID: <20131009141628.GB940@x2.net.home>
References: <alpine.LFD.2.03.1310092211290.7406@aslan.magister.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.03.1310092211290.7406@aslan.magister.com.au>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 09, 2013 at 10:23:13PM +1100, Craig wrote:
> Sorry if this isn't the place, but curiously, I could find no bug-reporting
> info in the documentation, and definitely I consider this one a bug!  Adding
> experimental GPT support to fdisk has completely broken its ability to read
> the MBR for a hybrid partitioning scheme.  To be blunt, I don't see the

It's more generic problem, we ignore MBR for hybrid GPT on more
places (for example in kernel and libblkid).

(Just for the record, hybrid GPT is ugly non-standard hack.)

> point in fdisk GPT support in any case; gdisk does a *vastly* better job,
> and appears to be mature.  At the least however, there needs urgently to be
> a means by which GPT can be disabled (command-line switch?) or by which
> fdisk can be forced to read an existing MBR under _any_ circumstances.

Seems like a good idea to have a way how to modify protective or hybrid
MBR on GPR devices.
 
    	# fdisk -l /dev/sda
    
    	Disk /dev/sda: 149.1 GiB, 160041885696 bytes, 312581808 sectors
    	Units: sectors of 1 * 512 = 512 bytes
    	Sector size (logical/physical): 512 bytes / 512 bytes
    	I/O size (minimum/optimal): 512 bytes / 512 bytes
    	Disklabel type: gpt
    	Disk identifier: 3549290F-417C-4941-8503-F7835109B821
    
    	Device           Start          End   Size Type
    	/dev/sda1         2048      2050047  1000M EFI System
    	/dev/sda2      2050048      6146047     2G Microsoft basic data
    	/dev/sda3      6146048     26462207   9.7G Linux swap
    	/dev/sda4     26462208     98142207  34.2G Microsoft basic data
    	/dev/sda5     98142208    230662143  63.2G Microsoft basic data
    	/dev/sda6    230662144    312580095  39.1G Microsoft basic data
    
but when GPT is disabled we can access PMBR:
    
    	# fdisk -l -t dos /dev/sda
    
    	Disk /dev/sda: 149.1 GiB, 160041885696 bytes, 312581808 sectors
    	Units: sectors of 1 * 512 = 512 bytes
    	Sector size (logical/physical): 512 bytes / 512 bytes
    	I/O size (minimum/optimal): 512 bytes / 512 bytes
    	Disklabel type: dos
    	Disk identifier: 0x00000000
    
    	Device    Boot Start       End    Blocks  Id System
    	/dev/sda1          1 312581807 156290903+ ee GPT
    
> On a related note, fdisk cannot differentiate between lower and upper-case
> command input (e.g., `G' vs. `g' is rather pointless as things stand).

 This is already fixed in git tree.

 .. all will be in v2.24-rc2. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
