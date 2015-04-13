Return-Path: util-linux-owner@vger.kernel.org
Received: from mta03.eastlink.ca ([24.224.136.9]:58377 "EHLO mta03.eastlink.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932507AbbDMN6S (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 09:58:18 -0400
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta03.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NMQ0071ETI76100@mta03.eastlink.ca> for
 util-linux@vger.kernel.org; Mon, 13 Apr 2015 10:58:16 -0300 (ADT)
Date: Mon, 13 Apr 2015 10:58:15 -0300
To: Sergey Zolotarev <szx@live.ru>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: Fix partition order killed my hard drive (twice)
Message-id: <20150413135815.GC3933@cordes.ca>
References: <DUB119-W10D0E142F9CF92AA8A3436B4E70@phx.gbl>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <DUB119-W10D0E142F9CF92AA8A3436B4E70@phx.gbl>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 13, 2015 at 04:11:05PM +0600, Sergey Zolotarev wrote:
> Hello,
> 
> Is it possible that fdisk could damage / kill a hard drive after using the "Fix partition order" command?
> [...]
> Both of HDDs seem unrecoverable.

 It's probably not the drive that's bad, it's just that your BIOS
won't boot when it's attached.  So boot without, THEN connect it via a
USB adapter.  Or via SATA.  (SATA is electrically safe to hotplug,
thanks to having the ground pins longer than any others, and Linux
handles it just as well as USB.  I never reboot to swap hard drives.
I only reboot to check that my system still boots if I've done
anything that might put that in doubt :P)

 Or set your BIOS to not even look at USB devices while booting.

> could it be the result of a corrupted / bad sector in the place where the partition table is stored?

 A badly-written BIOS could certainly have it's boot-sector detection
code get stuck in an infinite loop with unexpected inputs.  There's no
reason to believe the data read from the sector is anything other than
what fdisk wrote to it.  You can check with smartctl -a /dev/sdX once
you get it connected to a booted-up computer.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
