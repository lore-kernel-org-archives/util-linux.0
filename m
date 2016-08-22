Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp2.dds.nl ([83.96.147.103]:39294 "EHLO smtp2.dds.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbcHVMQn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Aug 2016 08:16:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 22 Aug 2016 14:16:40 +0200
From: Xen <list@xenhideout.nl>
To: Util linux <util-linux@vger.kernel.org>
Cc: Karel Zak <kzak@redhat.com>
Subject: Re: PV on disk without partitions not recognised as LVM2_member
In-Reply-To: <20160822084053.tthba5dmp6scyxbq@ws.net.home>
References: <c3d87222fe4f87eed72f61b6bc501344@dds.nl>
 <20160819111429.4rsuedff24inn4gu@ws.net.home>
 <3e1c8c5e88416d24f87bd411ca60488d@dds.nl>
 <20160822084053.tthba5dmp6scyxbq@ws.net.home>
Message-ID: <5cec655e021fcf074b5970002d7321be@dds.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak schreef op 22-08-2016 10:40:
> On Sat, Aug 20, 2016 at 04:13:52PM +0200, Xen wrote:
>> Karel Zak schreef op 19-08-2016 13:14:
>> 
>> > This is very unusual setup, but according to feedback from LVM guys
>> > it's supported, so I will improve blkid to support it too.
>> 
>> Actually there are more issues. If you have any firmware RAID 
>> signature at
>> the end of your disk, but you are not using it
> 
> You have to use "wipefs" to remove unwanted signatures. We do not
> support random mess on disks. It's OS installer, mkfs-like, fdisk
> tools and users responsibility to keep on-disk stuff in reliable
> state.

Right. I didn't know wipefs would do that. I am approaching this just as 
a user from this perspective. It's just a practical issue because RAID 
(firmware) (what they call fakeraid) is hard to use on Linux, not that 
obvious, dm-raid package is required, it is broken on Ubuntu, you are 
not likely to use pmc-whatever-undecipherable-string so fast if it is 
just JBOD.

JBOD of single disk (for some controllers that is spare disk, kinda) is 
probably raw disk + 1 MB.

I know it is crap, some controllers won't allow decent passthough and 
require you to configure every disk as a raid disk, creating the 
problems here.

I'll take note of wipefs but just the next user will run into it also. 
No shortage of things to learn before you can use your system ;-).


My problem is more lack of redundancy; all tools work together, and they 
work together perfectly, but if one slightly fails, the whole thing 
collapses, because they are all weakest links.

Whole udev system is liability, a single systemd vgscan service (like 
real lvm2.service file, no /etc/init.d) would solve every udev problem 
there could ever be with loading devices at boot; vgscan -ay will 
activate every device in the book that would also ordinarily have been 
activated by udev rules regardless.

Dependability on flawed or fallable or fragile system == .....

pvscan/vgscan/vgscan (I mean vgchange service) has the tools to deal 
with duplicate devices resulting from raid-based activation and raw 
device (same UUID, it handles it) so system is already resilient at the 
core but their udev rules make it break.

Single vgchange -ay would solve all issues but it is contrary to the 
design philosophy of streamlining everything with events.

I'm in favour of barriers and completion of stages: activate all LVM you 
can, only then activate filesystems.

If you have crypttarget based on LVM activation, sure streamlining it 
after the device has come online is not bad, or rather, auto-activate 
cryptsetup result using udev is not bad (form of hotplug, you might say) 
but manual calls work better and are robust and are resilient.

That's just my opinion. Too many things break in the Linux system when 
you change the smallest thing and it needs to "stop" as they say ;-).

Just kidding that. People who think they are awesome people sitting in 
their chairs say that a lot "this needs to stop!". Sure. I'm sure it 
does. Will you do it? Go back to your kitchen then, and make me some 
pie.

Claims of impotence, those are.

Anyway.

> It's not about RAIDs only, it's possible write many PT, filesystem and
> raid signatures to the same disk.

I agree but... this just means that person creating firmware raid array 
might cause the system to fail booting only because of blkid interlink 
and its interdependence. When otherwise it wouldn't. Filesystem / device 
is deemed RAID signature but partition table still loads.

So partition table loading not dependent on blkid == resilient. 
Microsoft Windows is notorious for failing to boot when you put a disk 
on a different controller etc. Millions, millions of boot problems when 
you change things. Change system from IDE to RAID, system will not load. 
AHCI same. Loads different driver. Doesn't load all drivers by default. 
I think Windows 10 has that sorted now. Not want to talk about Windows, 
just explanation of where it goes wrong there. Their boot recovery is 
abysmal. It just stinks. It stinks worse than Linux ever was, but Linux 
is now also not so resilient anymore.

Don't want to crack down on Linux, I am a Linux user. Still, just 
saying.

I would have a lot less headaches (or footaches) if the system was more 
robust. Just saying.

Just add an invalid line for /var to /etc/fstab and you will have a 
failing boot system.

Users are always asked to edit that file.

nofail and noauto not heeded. Just saying. SystemD pulls it in, you 
can't mask it either.

Crypt device that you don't need but it is in /etc/cryttab will require 
to be unlocked at boot, there is no intelligence to determine whether it 
would actually halt or obstruct the system, also no way to unlock it 
after boot, there is no software for that (no LUKS software for that) 
that is moderately user friendly.

Post-boot systems perhaps possible with VeraCrypt these days, nothing 
else.

VeraCrypt designers cause too many iteration cycles over TrueCrypt, now 
unusable system. Not user friendly anymore. Takes too long to unlock 
something. Not usable anymore. But they know better than actual users. 
Always know better than users.

Sorry for the rant, was not my intent ;-).

Regards, and thanks for your help.

Kudos.
