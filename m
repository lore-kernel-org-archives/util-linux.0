Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] tests: add test for loop option in fstab
To: Karel Zak <kzak@redhat.com>
References: <56BCE4F4.6020409@suse.cz> <201602151242.10369.sweet_f_a@gmx.de>
 <20160216144918.iqmvz27qggxfnjng@ws.net.home> <56C75E7B.60407@suse.cz>
 <20160222101233.imyhujomel6ydin3@ws.net.home> <56CB3909.4080808@suse.cz>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56CDFD40.7020603@suse.cz>
Date: Wed, 24 Feb 2016 19:58:08 +0100
MIME-Version: 1.0
In-Reply-To: <56CB3909.4080808@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Feb 22, 2016 at 17:36 Stanislav Brabec wrote:
> No, My new testcase fails on a system with mtab being a symlink:
>
> # ls -al /etc/mtab
> lrwxrwxrwx 1 root root 19 Jul  7  2015 /etc/mtab -> ../proc/self/mounts
>
> Not tested with a file.
>
I just analyzed the loop test case failure in deep. It has nothing to
do with mtab, but with a fact, that manual losetup with subsequent
mount commands recycle the same loop device, but -oloop allocates new
loop device for each mount where loop option is used.

And it is something that kernel does not like.

Here is a simplified example:
# losetup /dev/loop0 tests/output/mount/fstab-btrfs.img
# losetup /dev/loop1 tests/output/mount/fstab-btrfs.img
# mount /dev/loop0 /mnt/0
# mount -osubvol=/ /dev/loop1 /mnt/1
mount: /dev/loop1 is already mounted or /mnt/1 busy
        /dev/loop1 is already mounted on /mnt/1

Note: default of fstab-btrfs.img is not /, each mount should mount a
different sub-volume.

David, is it an expected kernel behavior?

If not, it is a kernel bug.

If yes, util-linux needs additional logic:

If "loop" options is used, check, whether the source equals to a source
of another loop mount. If it is, don't allocate new loop device, but
recycle existing one.

And reciprocally, if umount on such device is used, don't free the loop
device as long as there is another volume mounted that shares this
source.

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
