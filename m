Return-Path: quwenruo@cn.fujitsu.com
Message-ID: <534F90D2.1030807@cn.fujitsu.com>
Date: Thu, 17 Apr 2014 16:29:06 +0800
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
References: <534C9625.8030906@cn.fujitsu.com> <20140415112159.GE5786@x2.net.home> <534DD487.6090700@cn.fujitsu.com> <20140416090359.GF5786@x2.net.home> <534F2B8F.5010906@cn.fujitsu.com> <20140417082105.GH5786@x2.net.home>
In-Reply-To: <20140417082105.GH5786@x2.net.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <util-linux.vger.kernel.org>


-------- Original Message --------
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
From: Karel Zak <kzak@redhat.com>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Date: 2014=E5=B9=B404=E6=9C=8817=E6=97=A5 16:21
> On Thu, Apr 17, 2014 at 09:17:03AM +0800, Qu Wenruo wrote:
>> But after some tests, it seems that the ctime/mtime based cache seems no=
t
>> perfect due to the fact that multiple
> Yes, the cache is not perfect -- it was originally introduced by Ted
> in time when things was less complicated :-) The current goal is to
> avoid the cache usage, so we have low-level API in libblkid to bypass
> the cache at all, and in userspace we use this API or udev db. I guess
> that many users have the cache empty, because it's unnecessary for
> fsck, mount, lsblk, findmnt, systemd etc.
>
>> device file can be created in different fs with same major/minor number.
>> especially each of them has individual ctime/mtime timestamp.
>>
>> So if someone (maybe insane) use mknod to create as block device file an=
d
>> use 'btrfs dev del' on the newly created
>> block device file, libblkid will still be unable to detect the change si=
nce
>> the ctime/mtime of block device file in /dev/
>> does not change.
> Not sure if I understand, it would be nice to have complete example.
>
>      Karel
>
Sorry for my poor English.
Use /dev/sda6(major 8, minor 6) as an example.
------
# stat  /dev/sda6
   File: '/dev/sda6'
   Size: 0             Blocks: 0          IO Block: 4096   block special=20
file
Device: 5h/5d    Inode: 7289        Links: 1     Device type: 8,6
Access: (0660/brw-rw----)  Uid: (    0/    root)   Gid: (    6/ disk)
Access: 2014-04-17 12:30:08.981732698 +0800
Modify: 2014-04-17 12:30:08.981732698 +0800
Change: 2014-04-17 12:30:08.981732698 +0800
                                      ^^^^^^^^^^^^^^^^^
  Birth: -
# mknod sda6 b 8 6
# mkfs.ext4 ./sda6 <<< Not /dev/sda6
......
# stat  /dev/sda6
   File: '/dev/sda6'
   Size: 0             Blocks: 0          IO Block: 4096   block special=20
file
Device: 5h/5d    Inode: 7289        Links: 1     Device type: 8,6
Access: (0660/brw-rw----)  Uid: (    0/    root)   Gid: (    6/ disk)
Access: 2014-04-17 12:30:08.981732698 +0800
Modify: 2014-04-17 12:30:08.981732698 +0800
Change: 2014-04-17 12:30:08.981732698 +0800
                                        ^^^^^^^^^^^^^^^^ unchanged
  Birth: -

# stat  ./sda6
   File: './sda6'
   Size: 0             Blocks: 0          IO Block: 4096   block special=20
file
Device: 805h/2053d    Inode: 8889848     Links: 1     Device type: 8,6
Access: (0644/brw-r--r--)  Uid: (    0/    root)   Gid: (    0/ root)
Access: 2014-04-17 16:26:30.312439395 +0800
Modify: 2014-04-17 16:26:40.869106587 +0800
Change: 2014-04-17 16:26:40.869106587 +0800  <<< Only the created block=20
device file is updated
  Birth: -
------

Thanks,
Qu
