Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
To: Karel Zak <kzak@redhat.com>
References: <569FEF38.9010102@suse.cz> <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz> <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A15487.8020500@suse.cz>
Cc: util-linux@vger.kernel.org,
        =?UTF-8?B?RGF2aWQgxaB0xJtyYmE=?=
 <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56AA240F.5010900@suse.cz>
Date: Thu, 28 Jan 2016 15:22:07 +0100
MIME-Version: 1.0
In-Reply-To: <56A15487.8020500@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Stanislav Brabec wrote:
> Known problems not covered by this patch:
>
> - Use of subvolid= in fstab is not yet handled.

Patch already created, see mails:
[PATCH 1/2] libmount: run btrfs subvol checks for "subvolid" option
[PATCH 2/2] libmount: code re-indentation

> - Use of type auto in combination with subvol= in fstab is not yet
>    handled.

Patch already created, see:
[PATCH] libmount: run btrfs subvol checks for "auto" fs type

> - Use of btrfs in loop devices, where image file is specified in fstab is
>    not yet handled (use of /dev/loop0 in fstab works).

With all patches above, I cannot reproduce any more.
Tested situations:
- with and without "loop" option
- with "subvol" or "subvolid" options referring to non-default subvolume
- without "subvol" or "subvolid" referring to default subvolume
- with "btrfs" and "auto" fs type
=> I think that it is now fixed as well.

> - If fstab uses subvol=, and subvol path changes since last "mount -a",
>    subsequent "mount -a" will not recognize that it is already mounted,
>    and it will attempt to mount it second time. To fix it, libmount should
>    remember subvolid in time of mount (subvolid is unique for the
>    subvolume, subvol is not).

I have no plans to write a fix for that now. Too obscure situation.

> - mountinfo contains subvol and subvolid since kernel 4.2. Before kernel
>    4.2, there is no reasonable way to solve this situation. (One would
>    create temporary mount point, mount the default, call needed ioctl() to
>    determine what was mounted, deduce the default subvolume, compare it
>    with subvolume of mounted volume, unmount and return result.)

There is no reasonable way to detect whether default subvolume was mounted.

In case of mounting with subvolid, there is a way to detect subvolume 
path even before kernel 4.2: If mountinfo lookup fails, then use 
btrfs_get_default_subvolume_path(). (See my mail dated
Thu, 21 Jan 2016 18:24:59 +0100 in this thread.) However fix is possible 
here, I have no plan to extent
[PATCH 1/2] libmount: run btrfs subvol checks for "subvolid" option
and implement it. It would be a fix of obscure situation in a kernel 
with unfixable issues of more common cases.


Summary: After applying of all patches mentioned here, I consider btrfs 
support as fixed in new kernels.

I strongly discourage advanced use of btrfs in fstab before kernel 4.2.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
