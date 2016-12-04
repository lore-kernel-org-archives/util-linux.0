Return-Path: util-linux-owner@vger.kernel.org
Received: from forward5j.cmail.yandex.net ([5.255.227.23]:60498 "EHLO
        forward5j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750701AbcLDGvf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 4 Dec 2016 01:51:35 -0500
From: Constantine Kharlamov <hi-angel@ya.ru>
To: Karel Zak <kzak@redhat.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
In-Reply-To: <20161202121904.gqkjkhwg2tsemtry@ws.net.home>
References: <5303721479553110@web15g.yandex.ru> <20161202121904.gqkjkhwg2tsemtry@ws.net.home>
Subject: Re: sfdisk: -X option doesn't work
MIME-Version: 1.0
Message-Id: <12434941480833821@web26o.yandex.ru>
Date: Sun, 04 Dec 2016 09:43:41 +0300
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

02.12.2016, 15:19, "Karel Zak" <kzak@redhat.com>:
>   On Sat, Nov 19, 2016 at 01:58:30PM +0300, Constantine Kharlamov wrote:
>>    I've a disk that been GPT-formatted before, but now there's just MBR:
>>
>>            $ sudo sfdisk -l /dev/sdc
>>            Disk /dev/sdc: 14.9 GiB, 16025444352 bytes, 31299696 sectors
>>            Units: sectors of 1 * 512 = 512 bytes
>>            Sector size (logical/physical): 512 bytes / 512 bytes
>>            I/O size (minimum/optimal): 512 bytes / 512 bytes
>>            Disklabel type: dos
>>            Disk identifier: 0x79215d34
>>
>>            Device Boot Start End Sectors Size Id Type
>>            /dev/sdc1 2048 31299695 31297648 14.9G 83 Linux
>>
>>    Fine, but magically, both "/dev/disk/by-label/" and lsblk shows
>>    names/labels that been there before the disk reformatted into MBR!
>
>   /dev/disk/by-label, LABEL and UUID are *filesystem* identifiers. The
>   filesystem (partition content) and partition table are two independent
>   things.
>
>   If the partition (after conversion from GPT to MBR) starts still on
>   the same offset that the filesystem is still valid and identifiers
>   still visible for the system.
>
>>            $ sudo lsblk -o name,mountpoint,label,size,uuid /dev/sdc
>>            NAME MOUNTPOINT LABEL SIZE UUID
>>            sdc Ubuntu 15.10 amd64 14.9G 2015-10-21-16-17-40-00
>>            └─sdc1 Ubuntu 15.10 amd64 14.9G 502229b0-6d02-46ee-8fd1-b3321f11e53f
>>
>>    It causes errors with grub-install like "Attempting to install GRUB
>>    to a disk with multiple partition labels. This is not supported
>>    yet..".
>
>   You can try wipefs(8) to see what is on the sdc and sdc1. (BTW, the LABEL
>   for sdc seems strange.)
>
>   And you can use wipefs to remove obsolete GPT signature if there is
>   still for example backup GPT label. (Be careful, you can lost data on
>   the disk, don't use wipefs -a)


Beforehands, the problem have been solved by removing the iso9660 filesystem by offset. Back then the question have been asked on forum https://bbs.archlinux.org/viewtopic.php?pid=1670463 so I still have an output of wipefs's POV:

        $ sudo wipefs -n /dev/sdc
        offset type
        ----------------------------------------------------------------
        0x1fe PMBR [partition table]

        0x8001 iso9660 [filesystem]
                                                 LABEL: Ubuntu 15.10 amd64
                                                 UUID: 2015-10-21-16-17-40-00

I'm still curious about what happened though. α) iso9660 resides (offset 0x8001) faar inside the real (i.e. by MBR) filesystem (having offset 2048 ≅ 0x800). Hence, given the system shows the label of iso9660, the system (together with most partition utilities) assumed that sdc is using GPT. But β) I removed GPT completely with gdisk (expert command → wipe out GPT), so unless gdisk is buggy, it couldn't have happened!

To add even more confusion, there's γ) if the system assumed sdc is GPT formatted, the sdc1 should've been iso9660 rather than the actual ext4, and upon mounting sdc1 I should've been getting damaged iso9660 instead of absolutely fine ext4 with Archlinux.

>>    So I want to just remove those names. But "sgdisk" sees that GPT
>>    table is invalid, and tries to reconstruct it from MBR, whilst I'd
>>    need to force it into thinking like it is valid, so that it see the
>>    damn names.
>>
>>    Thankfully, there's sfdisk with -X option:
>
>   -X overrides default (MBR) or the current label type when you create
>   a new partition table, it has no effect for --list.
>
>   fdisk provides --type <name> that forces the util to use (e.g. print)
>   specified label, for example:
>
>     fdisk --list --type dos /dev/sdc

Ah, thank you, I see. It's not actually obvious that "disklabels" (from the manual) is a type of partition table (e.g. dos vs gpt). If you wouldn't say, I would've never guessed, even though I've read quite much for trying to fix the thing. Perhaps, would it be worth to change the wording in manual to mention partition table in some way. I don't know if it's fine, but e.g.:

	-t, --type type
				  Enable support only for disklabels (partition tables) of the specified type, and disable support for all other types.

"disklabels" alone sounds to me like, well, labels, which e.g. GPT allowed to have in a filesystem-independent way (though "dos" didn't, but that still does not reveal the purpose, rather confuses). I am not sure how widely the term is used, but I'd even remove it, or at least to try to diminish the significance of the word in the sentence, like "…partition tables (aka disklabels)…".
