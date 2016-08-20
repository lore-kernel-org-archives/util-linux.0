Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp2.dds.nl ([83.96.147.103]:44474 "EHLO smtp2.dds.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbcHTON5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Aug 2016 10:13:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sat, 20 Aug 2016 16:13:52 +0200
From: Xen <list@xenhideout.nl>
To: Util linux <util-linux@vger.kernel.org>
Cc: Karel Zak <kzak@redhat.com>
Subject: Re: PV on disk without partitions not recognised as LVM2_member
In-Reply-To: <20160819111429.4rsuedff24inn4gu@ws.net.home>
References: <c3d87222fe4f87eed72f61b6bc501344@dds.nl>
 <20160819111429.4rsuedff24inn4gu@ws.net.home>
Message-ID: <3e1c8c5e88416d24f87bd411ca60488d@dds.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak schreef op 19-08-2016 13:14:

> This is very unusual setup, but according to feedback from LVM guys
> it's supported, so I will improve blkid to support it too.

Actually there are more issues. If you have any firmware RAID signature 
at the end of your disk, but you are not using it, blkid will also give 
that raid signature precendence over LVM2_member, but LVM depends on 
that blkid scan to know what to do; and will fail to scan (even though 
pvscan could handle it easily) when the required Udev rule doesn't 
match.

So when this part is fixed, anyone who has mistakenly perhaps created a 
raid array out of their firmware BIOS, will end up with the same 
situation because .... how are we going to let LVM2_member take 
precedence just because it uses blkid to decide when to call itself 
honey?

I mean I can see good reasons why a RAID signature would take 
precedence.

In this case it just disrupts the system LVM2 has set up, in which there 
is no redundancy and it depends on an external tool to do its scanning 
:-/.

If you replaced that entire udev rule file with just a single command 
(and a block device filter) it would just always work with no pain, but 
because they want to minimize the number of pvscan invocations (even if 
it is just 3 extra invocations that don't harm anyone at every boot) the 
system now fails to work. In its entirety. Because it depends on blkid 
to provide the right signature.

So basically they could simplify the system and do away with udev in 
that sense at the cost of a minimal amount of extra pvscan invocations 
that don't really bring any cost to the table. But would they do it?

You now have a problem that cannot be solved:

- blkid cannot be asked to give precedence to LMV2_member over raid 
signatures
- while lvm2 chooses to depend on blkid, it won't find all PVs. It 
limits its search, but you can't really blame blkid for that unless 
blkid started giving multiple results for every device. It would need to 
become a list, a set. You can't ask that of blkid just for that right. 
So now you have an issue that has no solution. Because they depend on 
blkid instead of their own internal code, which wasn't really all that 
necessary. I mean it is nice to be needed at times.

But the only solution that would really be painless is to just dump that 
lvm2 udev file and replace it with something extremely simple. :-/. ;-).

What can I say. It seems obvious.

I mean that doesn't take away from the current issue with blkid not 
recognising PV when Grub is present. But it does show the bigger problem 
in this... I think.

Anyway, regards, and sorry for the verbosity at times. Regards.

