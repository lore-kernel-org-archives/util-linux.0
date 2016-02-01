Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
To: Karel Zak <kzak@redhat.com>
References: <569FEF38.9010102@suse.cz> <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz> <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A15487.8020500@suse.cz> <56AA240F.5010900@suse.cz>
 <20160201121811.tk3eqsr5x3w44p34@ws.net.home>
Cc: util-linux@vger.kernel.org,
        =?UTF-8?B?RGF2aWQgxaB0xJtyYmE=?=
 <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56AF7BE9.4000302@suse.cz>
Date: Mon, 1 Feb 2016 16:38:17 +0100
MIME-Version: 1.0
In-Reply-To: <20160201121811.tk3eqsr5x3w44p34@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> I did some changes to the code:
>
>   * use mnt_resolve_target() rather than mnt_resolve_spec() for target
>   * move all to get_btrfs_fs_root()
>   * make the basic if/else more readable

By the way, I am just fixing next btrfs issue. Now it is in blkid. And 
it seems, that I will need some changes in the code: move the btrfs 
default subvol function into the public API, and change it to return the 
subvolid string.

What do you think? Should I make this function linux or linux+btrfs 
specific (missing in the API/ABI otherwise, where include file would 
contain #define MOUNT_HAS_BTRFS_SUPPORT or so), or implement it for all 
systems. On unsupported systems it would always return NULL (the define 
could exist in this case as well, but it would be optional).

> Please, please, test it.

I'll test it. I think that the attached reproducer should work on any 
system with btrfs support.

> It would be nice to have tests/ts/mount/btrfs with all the "mount -a"
> variants you have in commit messages.

Are there any rules/framework for such tests that need root and editing 
of /etc/fstab?

I think that use of losetup and /dev/loopX can be used for most 
testcases. I am not sure about kernel partition table support inside 
loop devices.


And by the way, loop it the only device that can be used for TRIM 
testing: TRIM is internally converted to making unused blocks sparse.

Here is an example of TRIM testcase using loop:

dd if=/dev/null of=loop.img seek=1000000
mkfs.btrfs /root/loop.img
mount -oloop /root/loop.img /mnt
filefrag -e loop.img
for i in $(seq 0 100) ; do dd if=/dev/urandom of=/mnt/file$i bs=1M 
count=10 ; done
filefrag -e loop.img
rm /mnt/file*
fstrim /mnt
# wait some time to complete
filefrag -e loop.img

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
