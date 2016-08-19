Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp2.dds.nl ([83.96.147.103]:43930 "EHLO smtp2.dds.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754014AbcHSPLM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 Aug 2016 11:11:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 19 Aug 2016 17:10:00 +0200
From: Xen <list@xenhideout.nl>
To: Util linux <util-linux@vger.kernel.org>
Cc: Karel Zak <kzak@redhat.com>
Subject: Re: PV on disk without partitions not recognised as LVM2_member
In-Reply-To: <20160819111429.4rsuedff24inn4gu@ws.net.home>
References: <c3d87222fe4f87eed72f61b6bc501344@dds.nl>
 <20160819111429.4rsuedff24inn4gu@ws.net.home>
Message-ID: <d384013a5ab3f026f0cd5e322eeee597@dds.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak schreef op 19-08-2016 13:14:
> On Thu, Aug 18, 2016 at 10:39:30PM +0200, Xen wrote:
>> Would someone be will to fix the issue that a Physical Volume from 
>> LVM2 (PV)
>> when placed directly on disk (no partitions or partition tables) will 
>> not be
> 
> This is very unusual setup, but according to feedback from LVM guys
> it's supported, so I will improve blkid to support it too.

Thank you.

It is just extremely unusable because hardly anyone can do it yet.

The Grub support isn't there to boot from it (although I have a patch 
for that) and without being able to boot it no one would ordinarily use 
it. So it's just a chicken and the egg problem here.

As soon as they can get activated, people could start using them, but at 
this point it's almost impossible (it requires adjustments to systemd or 
the initrd that would be manual adjustments at this point).

Thanks :).

Regards.
