Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] tests: add test for loop option in fstab (my mistake, and
 two new bugs, one in kernel)
To: Karel Zak <kzak@redhat.com>
References: <56BCE4F4.6020409@suse.cz> <201602151242.10369.sweet_f_a@gmx.de>
 <20160216144918.iqmvz27qggxfnjng@ws.net.home> <56C75E7B.60407@suse.cz>
 <20160222101233.imyhujomel6ydin3@ws.net.home> <56CB3909.4080808@suse.cz>
 <56CDFD40.7020603@suse.cz> <56CE2199.6010509@suse.cz>
 <56CF5691.5010006@suse.cz>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56D5B4A9.4020805@suse.cz>
Date: Tue, 1 Mar 2016 16:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <56CF5691.5010006@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

On Feb 25, 2016 at 20:31 Stanislav Brabec wrote:
> On Feb 24, 2016 at 22:33 Stanislav Brabec wrote:
> 
>> => It looks like a kernel bug.
>> Kernel is openSUSE Tumbleweed linux-4.4.1-1.
> 
> Analyzed and sent to LKML.
> http://marc.info/?l=linux-kernel&m=145642818824430&w=2
> 
> It seems that problem reported here is triggered by multiple mounts 
> using multiple loop devices pointing to the same file.
> 
And not only that it breaks structures.

Even if structures will be kept in order, it will cause data
corruption: kernel does not have an information, that both loop devices
point to the same device:

Here is an analysis of Al Viro[1]:

Sigh...  sys_mount() (mount_bdev(), actually) has no way to tell if two
loop devices refer to the same underlying object.  As far as it's
concerned, you are asking to mount a completely unrelated block device.
Which just happens to see the data (living in separate pagecache, even)
modified behind its back (with some delay) after it gets written to another
device.  Filesystem drivers generally don't like when something is screwing
the underlying data, to put it mildly...

When you ask to mount the _same_ device, mount_bdev(), as well as btrfs
counterpart, makes sure that you get a reference to the same struct
super_block, which avoids all coherency problems - all mounted instances
refer to the same in-core objects (dentries, inodes, page cache, etc.).
They get separate struct vfsmount instances, but that only matters for
mountpoint crossing.

As soon as you've set the second /dev/loop alias for the same underlying
file, you are asking for all kinds of trouble.  If you use the same one
consistently, you are OK.  BTW, even
losetup /dev/loop0 /dev/sda1
mount -t ext2 /dev/sda1 /mnt/1
mount -t ext2 /dev/loop0 /mnt/2
is enough for trouble - you get (as far as ext2 knows) unrelated devices
screwing each other, with no good way to predict that.  And you need to
check propagation through more than one layer - loop over loop over block
is also possible.

IMO on-demand losetup a-la -o loop is simply a bad idea...

References:
[1] https://lkml.org/lkml/2016/2/26/897

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
