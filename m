Return-Path: util-linux-owner@vger.kernel.org
Received: from atl4mhob12.myregisteredsite.com ([209.17.115.50]:36341 "EHLO
	atl4mhob12.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758478Ab3EFW2t (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 May 2013 18:28:49 -0400
Received: from mailpod1.hostingplatform.com ([10.30.71.120])
	by atl4mhob12.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id r46MSmim011936
	for <util-linux@vger.kernel.org>; Mon, 6 May 2013 18:28:48 -0400
Message-ID: <51882EA5.9080805@chinilu.com>
Date: Mon, 06 May 2013 15:28:53 -0700
From: George Mitchell <george@chinilu.com>
Reply-To: george@chinilu.com
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: umount and findmnt commands not working with btrfs labels ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello all,  I am having problems with some sort of bug in the umount 
command that causes it not to process hyphenated labels on btrfs 
volumes.  Here is the scenario:


[root@localhost ghmitch]# mount -l

proc on /proc type proc (rw,relatime)

sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)

devtmpfs on /dev type devtmpfs 
(rw,nosuid,size=2065704k,nr_inodes=194082,mode=755)

devpts on /dev/pts type devpts 
(rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)

tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)

tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)

/dev/sde1 on / type btrfs (rw,relatime,space_cache) [MAGEIA3BTR]

/dev/sdc2 on /usr type btrfs (rw,relatime,space_cache) [MAGEIA3BTR-USR]

securityfs on /sys/kernel/security type securityfs 
(rw,nosuid,nodev,noexec,relatime)

tmpfs on /sys/fs/cgroup type tmpfs (rw,nosuid,nodev,noexec,mode=755)

cgroup on /sys/fs/cgroup/systemd type cgroup 
(rw,nosuid,nodev,noexec,relatime,release_agent=/usr/lib/systemd/systemd-cgroups-agent,name=systemd)

cgroup on /sys/fs/cgroup/cpuset type cgroup 
(rw,nosuid,nodev,noexec,relatime,cpuset)

cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup 
(rw,nosuid,nodev,noexec,relatime,cpuacct,cpu)

cgroup on /sys/fs/cgroup/devices type cgroup 
(rw,nosuid,nodev,noexec,relatime,devices)

cgroup on /sys/fs/cgroup/freezer type cgroup 
(rw,nosuid,nodev,noexec,relatime,freezer)

cgroup on /sys/fs/cgroup/net_cls type cgroup 
(rw,nosuid,nodev,noexec,relatime,net_cls)

cgroup on /sys/fs/cgroup/blkio type cgroup 
(rw,nosuid,nodev,noexec,relatime,blkio)

systemd-1 on /proc/sys/fs/binfmt_misc type autofs 
(rw,relatime,fd=22,pgrp=1,timeout=300,minproto=5,maxproto=5,direct)

mqueue on /dev/mqueue type mqueue (rw,relatime)

hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime)

debugfs on /sys/kernel/debug type debugfs (rw,relatime,mode=755)

fusectl on /sys/fs/fuse/connections type fusectl (rw,relatime)

none on /tmp type tmpfs (rw,relatime)

/dev/sdb5 on /boot type btrfs (rw,relatime,space_cache) [MAGEIA3BTR-BOOT]

/dev/sde3 on /home type btrfs (rw,relatime,space_cache) [HOME]

/dev/sde4 on /common type btrfs (rw,relatime,space_cache) [COMMON]

[root@localhost ghmitch]# umount LABEL=MAGEIA3BTR-BOOT

umount: LABEL=MAGEIA3BTR-BOOT: not found

[root@localhost ghmitch]# umount `mount -l | egrep "\[MAGEIA3BTR-BOOT\]" 
| cut -f1 -d" "`

[root@localhost ghmitch]# mount -l

proc on /proc type proc (rw,relatime)

sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)

devtmpfs on /dev type devtmpfs 
(rw,nosuid,size=2065704k,nr_inodes=194082,mode=755)

devpts on /dev/pts type devpts 
(rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)

tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)

tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)

/dev/sde1 on / type btrfs (rw,relatime,space_cache) [MAGEIA3BTR]

/dev/sdc2 on /usr type btrfs (rw,relatime,space_cache) [MAGEIA3BTR-USR]

securityfs on /sys/kernel/security type securityfs 
(rw,nosuid,nodev,noexec,relatime)

tmpfs on /sys/fs/cgroup type tmpfs (rw,nosuid,nodev,noexec,mode=755)

cgroup on /sys/fs/cgroup/systemd type cgroup 
(rw,nosuid,nodev,noexec,relatime,release_agent=/usr/lib/systemd/systemd-cgroups-agent,name=systemd)

cgroup on /sys/fs/cgroup/cpuset type cgroup 
(rw,nosuid,nodev,noexec,relatime,cpuset)

cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup 
(rw,nosuid,nodev,noexec,relatime,cpuacct,cpu)

cgroup on /sys/fs/cgroup/devices type cgroup 
(rw,nosuid,nodev,noexec,relatime,devices)

cgroup on /sys/fs/cgroup/freezer type cgroup 
(rw,nosuid,nodev,noexec,relatime,freezer)

cgroup on /sys/fs/cgroup/net_cls type cgroup 
(rw,nosuid,nodev,noexec,relatime,net_cls)

cgroup on /sys/fs/cgroup/blkio type cgroup 
(rw,nosuid,nodev,noexec,relatime,blkio)

systemd-1 on /proc/sys/fs/binfmt_misc type autofs 
(rw,relatime,fd=22,pgrp=1,timeout=300,minproto=5,maxproto=5,direct)

mqueue on /dev/mqueue type mqueue (rw,relatime)

hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime)

debugfs on /sys/kernel/debug type debugfs (rw,relatime,mode=755)

fusectl on /sys/fs/fuse/connections type fusectl (rw,relatime)

none on /tmp type tmpfs (rw,relatime)

/dev/sde3 on /home type btrfs (rw,relatime,space_cache) [HOME]

/dev/sde4 on /common type btrfs (rw,relatime,space_cache) [COMMON]

[root@localhost ghmitch]# mount LABEL=MAGEIA3BTR-BOOT

[root@localhost ghmitch]# mount -l

proc on /proc type proc (rw,relatime)

sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)

devtmpfs on /dev type devtmpfs 
(rw,nosuid,size=2065704k,nr_inodes=194082,mode=755)

devpts on /dev/pts type devpts 
(rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)

tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)

tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)

/dev/sde1 on / type btrfs (rw,relatime,space_cache) [MAGEIA3BTR]

/dev/sdc2 on /usr type btrfs (rw,relatime,space_cache) [MAGEIA3BTR-USR]

securityfs on /sys/kernel/security type securityfs 
(rw,nosuid,nodev,noexec,relatime)

tmpfs on /sys/fs/cgroup type tmpfs (rw,nosuid,nodev,noexec,mode=755)

cgroup on /sys/fs/cgroup/systemd type cgroup 
(rw,nosuid,nodev,noexec,relatime,release_agent=/usr/lib/systemd/systemd-cgroups-agent,name=systemd)

cgroup on /sys/fs/cgroup/cpuset type cgroup 
(rw,nosuid,nodev,noexec,relatime,cpuset)

cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup 
(rw,nosuid,nodev,noexec,relatime,cpuacct,cpu)

cgroup on /sys/fs/cgroup/devices type cgroup 
(rw,nosuid,nodev,noexec,relatime,devices)

cgroup on /sys/fs/cgroup/freezer type cgroup 
(rw,nosuid,nodev,noexec,relatime,freezer)

cgroup on /sys/fs/cgroup/net_cls type cgroup 
(rw,nosuid,nodev,noexec,relatime,net_cls)

cgroup on /sys/fs/cgroup/blkio type cgroup 
(rw,nosuid,nodev,noexec,relatime,blkio)

systemd-1 on /proc/sys/fs/binfmt_misc type autofs 
(rw,relatime,fd=22,pgrp=1,timeout=300,minproto=5,maxproto=5,direct)

mqueue on /dev/mqueue type mqueue (rw,relatime)

hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime)

debugfs on /sys/kernel/debug type debugfs (rw,relatime,mode=755)

fusectl on /sys/fs/fuse/connections type fusectl (rw,relatime)

none on /tmp type tmpfs (rw,relatime)

/dev/sde3 on /home type btrfs (rw,relatime,space_cache) [HOME]

/dev/sde4 on /common type btrfs (rw,relatime,space_cache) [COMMON]

/dev/sdb5 on /boot type btrfs (rw,relatime,space_cache) [MAGEIA3BTR-BOOT]

[root@localhost ghmitch]#
As you can see, mount has no problem with hyphenated btrfs labels. And 
when I use a workaround script to unmount the filesystem via a label, 
that works fine.  But the umount LABEL=XXX-00 format fails every time.  
This seems almost like a regression of sorts since I remember long ago 
having EXACTLY the same problem with umount and ext4 partitions.  The 
findmnt command also has problems with btrfs labels in general.  Every 
instance of `findmnt LABEL=XXX` I have tried on btrfs volumes fails.  
Example below:


[root@localhost ghmitch]# findmnt LABEL=MAGEIA3BTR [root@localhost 
ghmitch]# findmnt `mount -l | egrep "\[MAGEIA3BTR\]" | cut -f1 -d" "` 
TARGET SOURCE FSTYPE OPTIONS / /dev/sde1 btrfs rw,relatime,space_cache
