Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:34420 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758522AbcBXVdQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Feb 2016 16:33:16 -0500
Subject: Re: [PATCH] tests: add test for loop option in fstab (my mistake, and
 two new bugs, one in kernel)
To: Karel Zak <kzak@redhat.com>
References: <56BCE4F4.6020409@suse.cz> <201602151242.10369.sweet_f_a@gmx.de>
 <20160216144918.iqmvz27qggxfnjng@ws.net.home> <56C75E7B.60407@suse.cz>
 <20160222101233.imyhujomel6ydin3@ws.net.home> <56CB3909.4080808@suse.cz>
 <56CDFD40.7020603@suse.cz>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56CE2199.6010509@suse.cz>
Date: Wed, 24 Feb 2016 22:33:13 +0100
MIME-Version: 1.0
In-Reply-To: <56CDFD40.7020603@suse.cz>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Feb 24, 2016 at 19:58 Stanislav Brabec wrote:
> # mount -osubvol=/ /dev/loop1 /mnt/1
> mount: /dev/loop1 is already mounted or /mnt/1 busy
>         /dev/loop1 is already mounted on /mnt/1

OOPS, sorry, my mistake. I forgot loop mounted on /mnt/1 that confused
me.

But I already found a real explanation of the umount error in the test
case failure: There is a kernel bug!

# mount -oloop tests/output/mount/fstab-btrfs.img /mnt
# mount -oloop,subvol=/ tests/output/mount/fstab-btrfs.img /mnt2

Both succeeded and returned code 0.

Two mounts should be created, but only one is:

# mount | grep mnt
/dev/loop1 on /mnt type btrfs (rw,relatime,space_cache,subvolid=257,subvol=/d0/dd0/ddd0/s1/d1/dd1/ddd1/s2)

Yes, /mnt2 was ignored.

Once I
umount /mnt
it succeeds:
# mount | grep mnt
/home/sbrabec/util-linux/tests/output/mount/fstab-btrfs.img on /mnt2 type btrfs (rw,relatime,space_cache,subvolid=5,subvol=/)

Surprisingly, the format of the mount line is different.

And even more surprisingly, strace shows:

mount("/dev/loop1", "/mnt2", "btrfs", MS_MGC_VAL, "subvol=/") = 0
access("/mnt2", W_OK)                   = 0

=> It looks like a kernel bug.
Kernel is openSUSE Tumbleweed linux-4.4.1-1.


Looking deeper, the different format of lines seems to be util-linux
fault, because /proc/self/mountinfo lines are in an equal format:

222 59 0:71 /d0/dd0/ddd0/s1/d1/dd1/ddd1/s2 /mnt rw,relatime shared:150 - btrfs /dev/loop0 rw,space_cache,subvolid=257,subvol=/d0/dd0/ddd0/s1/d1/dd1/ddd1/s2

222 59 0:71 / /mnt2 rw,relatime shared:150 - btrfs /dev/loop0 rw,space_cache,subvolid=5,subvol=/

=> This one looks like an util-linux bug.


It seems, that also the code evaluating loop mounts needs btrfs default
subvolume check. Because it starts to work, if I specify subvol or
subvolid of the default mount explicitly.

# mount -oloop,subvol=/d0/dd0/ddd0/s1/d1/dd1/ddd1/s2 tests/output/mount/fstab-btrfs.img /mnt
/home/sbrabec/util-linux/tests/output/mount/fstab-btrfs.img on /mnt type btrfs (rw,relatime,space_cache,subvolid=257,subvol=/d0/dd0/ddd0/s1/d1/dd1/ddd1/s2)
# mount -oloop,subvolid=257 tests/output/mount/fstab-btrfs.img /mnt
# mount | grep mnt
/home/sbrabec/util-linux/tests/output/mount/fstab-btrfs.img on /mnt type btrfs (rw,relatime,space_cache,subvolid=257,subvol=/d0/dd0/ddd0/s1/d1/dd1/ddd1/s2)

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
