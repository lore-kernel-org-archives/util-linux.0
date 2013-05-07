Return-Path: george@chinilu.com
Message-ID: <51891448.5010804@chinilu.com>
Date: Tue, 07 May 2013 07:48:40 -0700
From: George Mitchell <george@chinilu.com>
Reply-To: george@chinilu.com
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: umount and findmnt commands not working with btrfs labels ...
References: <51882EA5.9080805@chinilu.com> <20130507094835.GB7086@x2.net.home>
In-Reply-To: <20130507094835.GB7086@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 05/07/2013 02:48 AM, Karel Zak wrote:
>   Hi George,
>
> On Mon, May 06, 2013 at 03:28:53PM -0700, George Mitchell wrote:
>> [root@localhost ghmitch]# umount LABEL=MAGEIA3BTR-BOOT
>>
>> umount: LABEL=MAGEIA3BTR-BOOT: not found
>   umount --version ?
>
>   It works for me (tested with util-linux 2.22 and 2.23):
>
>    # mkfs.btrfs -L MAGEIA3BTR /dev/sdb1
>    # mkfs.btrfs -L MAGEIA3BTR-FOO /dev/sdb2
>
>    # mount LABEL=MAGEIA3BTR /mnt/test
>    # mount LABEL=MAGEIA3BTR-FOO /mnt/test
>
>    # findmnt LABEL=MAGEIA3BTR
>    TARGET    SOURCE    FSTYPE OPTIONS
>    /mnt/test /dev/sdb1 btrfs  rw,relatime,ssd,space_cache
>
>    # findmnt LABEL=MAGEIA3BTR-FOO
>    TARGET     SOURCE    FSTYPE OPTIONS
>    /mnt/test2 /dev/sdb2 btrfs  rw,relatime,ssd,space_cache
>
>    # umount LABEL=MAGEIA3BTR
>    # umount LABEL=MAGEIA3BTR-FOO
>
>    # lsblk --fs /dev/sdb
>    NAME   FSTYPE LABEL          UUID                                 MOUNTPOINT
>    sdb
>    ├─sdb1 btrfs  MAGEIA3BTR     6dcc3293-ce27-474f-ab31-dd7a8e5bb2da
>    └─sdb2 btrfs  MAGEIA3BTR-FOO f3bb2d57-8b46-40a0-ae76-50d78268d6d9
>
>
> It would be nice to have a simple reproducible scenario rather than a
> lot of mount -l outputs and some egrep tricks :-)
>
> You can also try
>
>    LIBMOUNT_DEBUG=0xffff umount LABEL=MAGEIA3BTR-BOOT
>
> to see more details.
>
>      Karel
>
At this point findmnt works on MAGEIA3BTR-BOOT on which I previously 
executed the umount with the debug prefix.  findmnt still does NOT work 
with MAGEIA3BTR (the root partition) or MAGEIA3BTR-USR (the usr 
partition).  Since I am not able to unmount either of these on a running 
system with the debug statement, I have no way of knowing whether that 
would fix the problem.  Is there a different debug statement I can use 
with findmnt?  What I also don't know at this point is whether this is 
going to be a permanent fix or whether I will need to redo this with 
each reboot?  Also you did your testing with a simple one partition 
btrfs volume.  My system involves up to five partitions in a single RAID 
1 volume.  My boot volume is spread over two partitions.  I am wondering 
if that could have something to do with it?  In any case, here is what I 
come up with using the same debug prefix with findmnt.

Using findmnt on MAGEIA3BTR-BOOT produces the following.  It appears to 
find the mount point and then print the result:

[root@localhost ghmitch]# LIBMOUNT_DEBUG=0xffff findmnt 
LABEL=MAGEIA3BTR-BOOT
libmount: debug mask set to 0xffff.
4859: libmount:      TAB: [0x97a6878]: alloc
4859: libmount:      TAB: [0x97a6878]: /proc/self/mountinfo: start 
parsing [entries=0, filter=not]
4859: libmount:      TAB: trying to guess table type
4859: libmount:      TAB: [0x97a6878]: add entry: proc /proc
4859: libmount:      TAB: TID for /proc/self/mountinfo is 4859
4859: libmount:      TAB: [0x97a6878]: add entry: sysfs /sys
4859: libmount:      TAB: [0x97a6878]: add entry: devtmpfs /dev
4859: libmount:      TAB: [0x97a6878]: add entry: devpts /dev/pts
4859: libmount:      TAB: [0x97a6878]: add entry: tmpfs /dev/shm
4859: libmount:      TAB: [0x97a6878]: add entry: tmpfs /run
4859: libmount:      TAB: [0x97a6878]: add entry: /dev/sde1 /
4859: libmount:      TAB: [0x97a6878]: add entry: /dev/sdc2 /usr
4859: libmount:      TAB: [0x97a6878]: add entry: securityfs 
/sys/kernel/security
4859: libmount:      TAB: [0x97a6878]: add entry: tmpfs /sys/fs/cgroup
4859: libmount:      TAB: [0x97a6878]: add entry: cgroup 
/sys/fs/cgroup/systemd
4859: libmount:      TAB: [0x97a6878]: add entry: cgroup 
/sys/fs/cgroup/cpuset
4859: libmount:      TAB: [0x97a6878]: add entry: cgroup 
/sys/fs/cgroup/cpu,cpuacct
4859: libmount:      TAB: [0x97a6878]: add entry: cgroup 
/sys/fs/cgroup/devices
4859: libmount:      TAB: [0x97a6878]: add entry: cgroup 
/sys/fs/cgroup/freezer
4859: libmount:      TAB: [0x97a6878]: add entry: cgroup 
/sys/fs/cgroup/net_cls
4859: libmount:      TAB: [0x97a6878]: add entry: cgroup 
/sys/fs/cgroup/blkio
4859: libmount:      TAB: [0x97a6878]: add entry: systemd-1 
/proc/sys/fs/binfmt_misc
4859: libmount:      TAB: [0x97a6878]: add entry: mqueue /dev/mqueue
4859: libmount:      TAB: [0x97a6878]: add entry: hugetlbfs /dev/hugepages
4859: libmount:      TAB: [0x97a6878]: add entry: debugfs /sys/kernel/debug
4859: libmount:      TAB: [0x97a6878]: add entry: fusectl 
/sys/fs/fuse/connections
4859: libmount:      TAB: [0x97a6878]: add entry: none /tmp
4859: libmount:      TAB: [0x97a6878]: add entry: /dev/sde3 /home
4859: libmount:      TAB: [0x97a6878]: add entry: /dev/sde4 /common
4859: libmount:      TAB: [0x97a6878]: add entry: /dev/sdb5 /boot
4859: libmount:      TAB: [0x97a6878]: /proc/self/mountinfo: stop 
parsing (26 entries)
4859: libmount:    CACHE: [0x97a68a0]: alloc
4859: libmount:      TAB: [0x97a6878]: lookup next fs
4859: libmount:    CACHE: [0x97a68a0]: add entry [ 1] (tag): /dev/sdb5: 
LABEL
4859: libmount:    CACHE: [0x97a68a0]: add entry [ 2] (path): /dev/sde1: 
/dev/sde1
4859: libmount:    CACHE: [0x97a68a0]: add entry [ 3] (path): /dev/sdc2: 
/dev/sdc2
4859: libmount:    CACHE: [0x97a68a0]: add entry [ 4] (path): /dev/sde3: 
/dev/sde3
4859: libmount:    CACHE: [0x97a68a0]: add entry [ 5] (path): /dev/sde4: 
/dev/sde4
4859: libmount:      TAB: [0x97a6878]: lookup next fs
TARGET SOURCE    FSTYPE OPTIONS
/boot  /dev/sdb5 btrfs  rw,relatime,space_cache
4859: libmount:      TAB: [0x97a6878]: reset
4859: libmount:      TAB: [0x97a6878]: free
4859: libmount:    CACHE: [0x97a68a0]: free

However, when I do the same operation with MAGEIA3BTR, it DOES seem to 
find the mount point (4814: libmount:    CACHE: [0x861c8a0]: add entry [ 
1] (tag): /dev/sdd1: LABEL).  The problem is, that is NOT the mount 
point.  The mount point is /dev/sde1.

[root@localhost ghmitch]# LIBMOUNT_DEBUG=0xffff findmnt LABEL=MAGEIA3BTR
libmount: debug mask set to 0xffff.
4814: libmount:      TAB: [0x861c878]: alloc
4814: libmount:      TAB: [0x861c878]: /proc/self/mountinfo: start 
parsing [entries=0, filter=not]
4814: libmount:      TAB: trying to guess table type
4814: libmount:      TAB: [0x861c878]: add entry: proc /proc
4814: libmount:      TAB: TID for /proc/self/mountinfo is 4814
4814: libmount:      TAB: [0x861c878]: add entry: sysfs /sys
4814: libmount:      TAB: [0x861c878]: add entry: devtmpfs /dev
4814: libmount:      TAB: [0x861c878]: add entry: devpts /dev/pts
4814: libmount:      TAB: [0x861c878]: add entry: tmpfs /dev/shm
4814: libmount:      TAB: [0x861c878]: add entry: tmpfs /run
4814: libmount:      TAB: [0x861c878]: add entry: /dev/sde1 /
4814: libmount:      TAB: [0x861c878]: add entry: /dev/sdc2 /usr
4814: libmount:      TAB: [0x861c878]: add entry: securityfs 
/sys/kernel/security
4814: libmount:      TAB: [0x861c878]: add entry: tmpfs /sys/fs/cgroup
4814: libmount:      TAB: [0x861c878]: add entry: cgroup 
/sys/fs/cgroup/systemd
4814: libmount:      TAB: [0x861c878]: add entry: cgroup 
/sys/fs/cgroup/cpuset
4814: libmount:      TAB: [0x861c878]: add entry: cgroup 
/sys/fs/cgroup/cpu,cpuacct
4814: libmount:      TAB: [0x861c878]: add entry: cgroup 
/sys/fs/cgroup/devices
4814: libmount:      TAB: [0x861c878]: add entry: cgroup 
/sys/fs/cgroup/freezer
4814: libmount:      TAB: [0x861c878]: add entry: cgroup 
/sys/fs/cgroup/net_cls
4814: libmount:      TAB: [0x861c878]: add entry: cgroup 
/sys/fs/cgroup/blkio
4814: libmount:      TAB: [0x861c878]: add entry: systemd-1 
/proc/sys/fs/binfmt_misc
4814: libmount:      TAB: [0x861c878]: add entry: mqueue /dev/mqueue
4814: libmount:      TAB: [0x861c878]: add entry: hugetlbfs /dev/hugepages
4814: libmount:      TAB: [0x861c878]: add entry: debugfs /sys/kernel/debug
4814: libmount:      TAB: [0x861c878]: add entry: fusectl 
/sys/fs/fuse/connections
4814: libmount:      TAB: [0x861c878]: add entry: none /tmp
4814: libmount:      TAB: [0x861c878]: add entry: /dev/sde3 /home
4814: libmount:      TAB: [0x861c878]: add entry: /dev/sde4 /common
4814: libmount:      TAB: [0x861c878]: add entry: /dev/sdb5 /boot
4814: libmount:      TAB: [0x861c878]: /proc/self/mountinfo: stop 
parsing (26 entries)
4814: libmount:    CACHE: [0x861c8a0]: alloc
4814: libmount:      TAB: [0x861c878]: lookup next fs
4814: libmount:    CACHE: [0x861c8a0]: add entry [ 1] (tag): /dev/sdd1: 
LABEL
4814: libmount:    CACHE: [0x861c8a0]: add entry [ 2] (path): /dev/sde1: 
/dev/sde1
4814: libmount:    CACHE: [0x861c8a0]: add entry [ 3] (path): /dev/sdc2: 
/dev/sdc2
4814: libmount:    CACHE: [0x861c8a0]: add entry [ 4] (path): /dev/sde3: 
/dev/sde3
4814: libmount:    CACHE: [0x861c8a0]: add entry [ 5] (path): /dev/sde4: 
/dev/sde4
4814: libmount:    CACHE: [0x861c8a0]: add entry [ 6] (path): /dev/sdb5: 
/dev/sdb5
4814: libmount:      TAB: [0x861c878]: reset
4814: libmount:      TAB: [0x861c878]: free
4814: libmount:    CACHE: [0x861c8a0]: free

Here is my blkid which will give you an overview of the partitions 
involved.  NOTE that with btrfs there are often multiple partitions with 
the same LABEL and UUID, but only ONE of those will be the mount point 
and that mount point can change at any time to one of the OTHER 
partitions sharing the same label.  If umount OR findmnt happen to get 
the wrong mountpoint even with the right label, things are not going to 
work out:

/dev/sda5: LABEL="MAGEIA3BTR-BOOT" 
UUID="63f13151-dd34-45e1-b40d-7ed7d0d0ec4a" 
UUID_SUB="978f5c02-5e11-4df4-8f72-4ff6d09e58ff" TYPE="btrfs"
/dev/sda6: LABEL="MAGEIA3X64-BOOT" 
UUID="9b4a4323-2e8a-46bb-8773-a37a6d9e663d" TYPE="ext4"
/dev/sda7: UUID="aac18bf5-9d32-4b4d-99ae-31bd19b23f10" TYPE="ext4"
/dev/sdb5: LABEL="MAGEIA3BTR-BOOT" 
UUID="63f13151-dd34-45e1-b40d-7ed7d0d0ec4a" 
UUID_SUB="0587a676-8bad-4d61-a8af-0e262d997ba7" TYPE="btrfs"
/dev/sdb6: UUID="8b3905fa-9431-4ca2-b88d-2f3382790e10" TYPE="ext4"
/dev/sdc1: LABEL="MAGEIA3BTR" 
UUID="2ead7897-2203-4846-9fef-22aac314634d" 
UUID_SUB="9f1a5494-eb9b-48d1-8169-2e10682f0ed7" TYPE="btrfs"
/dev/sdc2: LABEL="MAGEIA3BTR-USR" 
UUID="d2bd46ff-c25d-4302-b708-76e81dc09977" 
UUID_SUB="fb11bf5c-5fcc-4f43-a8b5-502f7f3b80b2" TYPE="btrfs"
/dev/sdc3: LABEL="HOME" UUID="f5bb2e04-2a27-4d8c-9b59-a637f3a51e9a" 
UUID_SUB="d730117f-5293-4d73-b1e1-213550bb58aa" TYPE="btrfs"
/dev/sdc4: LABEL="COMMON" UUID="4b0983d7-8d85-463d-85c1-c20aa3b4fa3b" 
UUID_SUB="2fed487e-c68a-4688-8ab7-526751d50e62" TYPE="btrfs"
/dev/sdd1: LABEL="MAGEIA3BTR" 
UUID="2ead7897-2203-4846-9fef-22aac314634d" 
UUID_SUB="831dcba5-ace6-44a4-8a23-94ac38f397f6" TYPE="btrfs"
/dev/sdd2: LABEL="MAGEIA3BTR-USR" 
UUID="d2bd46ff-c25d-4302-b708-76e81dc09977" 
UUID_SUB="69befc01-5166-466a-b16f-e360a1acd591" TYPE="btrfs"
/dev/sdd3: LABEL="HOME" UUID="f5bb2e04-2a27-4d8c-9b59-a637f3a51e9a" 
UUID_SUB="54ff9459-5487-42f8-a8f8-4d6eaa0cd6ef" TYPE="btrfs"
/dev/sdd4: LABEL="COMMON" UUID="4b0983d7-8d85-463d-85c1-c20aa3b4fa3b" 
UUID_SUB="91b80d1e-1a9c-4a1a-9f5f-e396ea205085" TYPE="btrfs"
/dev/sde1: LABEL="MAGEIA3BTR" 
UUID="2ead7897-2203-4846-9fef-22aac314634d" 
UUID_SUB="1c815643-ceb5-4cc8-be6b-35e3d4262dd1" TYPE="btrfs"
/dev/sde2: LABEL="MAGEIA3X64" 
UUID="6c63a6ad-def8-47d5-95cb-6fba898b1578" TYPE="ext4"
/dev/sde3: LABEL="HOME" UUID="f5bb2e04-2a27-4d8c-9b59-a637f3a51e9a" 
UUID_SUB="8e3a2572-7ab7-4aac-9c01-497a06541786" TYPE="btrfs"
/dev/sde4: LABEL="COMMON" UUID="4b0983d7-8d85-463d-85c1-c20aa3b4fa3b" 
UUID_SUB="8e4a1292-980a-4815-9d1f-c43c312bfeb8" TYPE="btrfs"
/dev/sdf2: LABEL="MAGEIA3BTR-USR" 
UUID="d2bd46ff-c25d-4302-b708-76e81dc09977" 
UUID_SUB="3cc25d5d-534a-4ae5-a5f8-20648cb8c33c" TYPE="btrfs"
/dev/sdf3: LABEL="HOME" UUID="f5bb2e04-2a27-4d8c-9b59-a637f3a51e9a" 
UUID_SUB="9bea9ca7-73e9-4290-bc8b-b94771c3e362" TYPE="btrfs"
/dev/sdf4: LABEL="COMMON" UUID="4b0983d7-8d85-463d-85c1-c20aa3b4fa3b" 
UUID_SUB="1e459a35-ed8d-4021-b6ea-161bda96305a" TYPE="btrfs"
/dev/sdg2: LABEL="MAGEIA3BTR-USR" 
UUID="d2bd46ff-c25d-4302-b708-76e81dc09977" 
UUID_SUB="6bc4b144-c90c-4df5-9008-6a98934b55e4" TYPE="btrfs"
/dev/sdg3: LABEL="HOME" UUID="f5bb2e04-2a27-4d8c-9b59-a637f3a51e9a" 
UUID_SUB="206f43d8-f51a-4080-b674-26de2dea5ce5" TYPE="btrfs"
/dev/sdg4: LABEL="COMMON" UUID="4b0983d7-8d85-463d-85c1-c20aa3b4fa3b" 
UUID_SUB="92bfb4cb-9f4b-4277-ad5e-fe6cf34d368f" TYPE="btrfs"
/dev/sdh1: LABEL="HOME_MIRROR" 
UUID="725f431e-0d70-49d5-b0d6-ca2805385dc9" TYPE="jfs" 
PARTUUID="850816a4-2cb1-40f2-ac8b-23fedda3f40f"
/dev/sdi: LABEL="BACKUP" UUID="534d18b0-fc56-42e6-bfeb-c63b0f0bdc07" 
UUID_SUB="8467e093-5f14-4124-98e5-fb80303ec851" TYPE="btrfs"
