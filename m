Return-Path: util-linux-owner@vger.kernel.org
Received: from drutsystem.com ([84.10.39.251]:40264 "EHLO drutsystem.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbdBANhV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 1 Feb 2017 08:37:21 -0500
Subject: Re: findmnt under container
To: Karel Zak <kzak@redhat.com>
References: <008ff846-8010-44ef-2056-5e0ecdc355c1@ziu.info>
 <20170201114246.tpjirhsk52qaijuo@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Michal Soltys <soltys@ziu.info>
Message-ID: <3716efe8-d5bd-c4af-4180-975fa3a112cb@ziu.info>
Date: Wed, 1 Feb 2017 14:37:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170201114246.tpjirhsk52qaijuo@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/01/2017 12:42 PM, Karel Zak wrote:
> On Wed, Feb 01, 2017 at 12:10:38PM +0100, Michal Soltys wrote:
>> Hi,
>>
>> If I start a container by say systemd-nspawn (also tested with ubuntu
>> through debootstrap):
>>
>> pacstrap -c -d arch base
>> systemd-nspawn -b -D arch
>>
>> then findmnt without any arguments just returns one line (to be precise - it
>> always seems to be the first mount under /sys/fs/cgroup), e.g.:
>>
>> /sys/fs/cgroup/devices cgroup cgroup ro,nosuid,nodev,noexec,relatime,devices
> 
>  1) /proc/self/mountinfo content?
> 
>  2) try: LIBMOUNT_DEBUG=all findmnt
> 
>     Karel
> 

ad. 1

220 189 8:3 /arch / rw,relatime shared:50 - ext4 /dev/sda3 rw
221 220 0:17 / /sys ro,nosuid,nodev,noexec,relatime shared:51 - sysfs sysfs rw
222 220 0:52 / /dev rw,nosuid shared:52 - tmpfs tmpfs rw,mode=755
223 222 0:53 / /dev/shm rw,nosuid,nodev shared:53 - tmpfs tmpfs rw
224 222 0:56 / /dev/pts rw,nosuid,noexec,relatime shared:56 - devpts devpts rw,gid=5,mode=620,ptmxmode=666
225 222 0:21 /5 /dev/console rw,nosuid,noexec,relatime shared:57 master:4 - devpts devpts rw,gid=5,mode=620,ptmxmode=000
226 220 0:54 / /run rw,nosuid,nodev shared:54 - tmpfs tmpfs rw,mode=755
227 226 0:18 /systemd/nspawn/propagate/arch /run/systemd/nspawn/incoming ro,relatime master:11 - tmpfs run rw,mode=755
228 220 0:55 / /tmp rw shared:55 - tmpfs tmpfs rw
231 220 0:58 / /proc rw,nosuid,nodev,noexec,relatime shared:58 - proc proc rw
232 231 0:58 /sys /proc/sys ro,nosuid,nodev,noexec,relatime shared:58 - proc proc rw
233 231 0:58 /sysrq-trigger /proc/sysrq-trigger ro,nosuid,nodev,noexec,relatime shared:58 - proc proc rw
93 221 0:59 / /sys/fs/cgroup ro,nosuid,nodev,noexec shared:59 - tmpfs tmpfs ro,mode=755
94 93 0:29 / /sys/fs/cgroup/perf_event ro,nosuid,nodev,noexec,relatime shared:60 - cgroup cgroup rw,perf_event
95 93 0:31 / /sys/fs/cgroup/net_cls ro,nosuid,nodev,noexec,relatime shared:61 - cgroup cgroup rw,net_cls
96 93 0:30 / /sys/fs/cgroup/blkio ro,nosuid,nodev,noexec,relatime shared:62 - cgroup cgroup rw,blkio
98 93 0:33 / /sys/fs/cgroup/memory ro,nosuid,nodev,noexec,relatime shared:63 - cgroup cgroup rw,memory
99 93 0:32 / /sys/fs/cgroup/pids ro,nosuid,nodev,noexec,relatime shared:64 - cgroup cgroup rw,pids
100 93 0:27 / /sys/fs/cgroup/cpuset ro,nosuid,nodev,noexec,relatime shared:65 - cgroup cgroup rw,cpuset
101 93 0:25 / /sys/fs/cgroup/freezer ro,nosuid,nodev,noexec,relatime shared:66 - cgroup cgroup rw,freezer
102 93 0:28 / /sys/fs/cgroup/cpu,cpuacct ro,nosuid,nodev,noexec,relatime shared:67 - cgroup cgroup rw,cpu,cpuacct
103 93 0:26 / /sys/fs/cgroup/devices ro,nosuid,nodev,noexec,relatime shared:68 - cgroup cgroup rw,devices
104 93 0:23 / /sys/fs/cgroup/systemd rw,nosuid,nodev,noexec,relatime shared:69 - cgroup cgroup rw,xattr,release_agent=/usr/lib/systemd/systemd-cgroups-agent,name=systemd
105 232 0:54 /proc-sys-kernel-random-boot-id//deleted /proc/sys/kernel/random/boot_id ro,nosuid,nodev shared:54 - tmpfs tmpfs rw,mode=755
106 231 0:54 /proc-sys-kernel-random-boot-id//deleted /proc/sys/kernel/random/boot_id rw,nosuid,nodev shared:54 - tmpfs tmpfs rw,mode=755
107 231 0:54 /kmsg//deleted /proc/kmsg rw,nosuid,nodev shared:54 - tmpfs tmpfs rw,mode=755
97 222 0:57 / /dev/mqueue rw,relatime shared:70 - mqueue mqueue rw
108 222 0:60 / /dev/hugepages rw,relatime shared:71 - hugetlbfs hugetlbfs rw
109 226 0:61 / /run/user/0 rw,nosuid,nodev,relatime shared:72 - tmpfs tmpfs rw,size=1634120k,mode=700

ad. 2

65: libmount:     INIT: library debug mask: 0xffff
65: libmount:     INIT: library version: 2.29.1
65: libmount:     INIT:     feature: btrfs
65: libmount:     INIT:     feature: assert
65: libmount:     INIT:     feature: debug
Available "LIBMOUNT_DEBUG=<name>[,...]|<mask>" debug masks:
   all      [0xffff] : info about all subsystems
   cache    [0x0004] : paths and tags cache
   cxt      [0x0200] : library context (handler)
   diff     [0x0400] : mountinfo changes tracking
   fs       [0x0040] : FS abstraction
   help     [0x0001] : this help
   locks    [0x0010] : mtab and utab locking
   loop     [0x2000] : loop devices routines
   options  [0x0008] : mount options parsing
   tab      [0x0020] : fstab, mtab, mountinfo routines
   update   [0x0080] : mtab, utab updates
   utils    [0x0100] : misc library utils
   monitor  [0x0800] : mount tables monitor
   btrfs    [0x1000] : btrfs specific routines
65: libmount:      TAB: [0x1ede050]: alloc
65: libmount:      TAB: [0x1ede050]: /proc/self/mountinfo: start parsing [entries=0, filter=not]
65: libmount:      TAB: trying to guess table type
65: libmount:      TAB: [0x1ede050]: add entry: /dev/sda3 /
65: libmount:    CACHE: canonicalize path /proc/self/mountinfo
65: libmount:      TAB: TID for /proc/self/mountinfo is 65
65: libmount:      TAB: [0x1ede050]: add entry: sysfs /sys
65: libmount:      TAB: [0x1ede050]: add entry: tmpfs /dev
65: libmount:      TAB: [0x1ede050]: add entry: tmpfs /dev/shm
65: libmount:      TAB: [0x1ede050]: add entry: devpts /dev/pts
65: libmount:      TAB: [0x1ede050]: add entry: devpts /dev/console
65: libmount:      TAB: [0x1ede050]: add entry: tmpfs /run
65: libmount:      TAB: [0x1ede050]: add entry: run /run/systemd/nspawn/incoming
65: libmount:      TAB: [0x1ede050]: add entry: tmpfs /tmp
65: libmount:      TAB: [0x1ede050]: add entry: proc /proc
65: libmount:      TAB: [0x1ede050]: add entry: proc /proc/sys
65: libmount:      TAB: [0x1ede050]: add entry: proc /proc/sysrq-trigger
65: libmount:      TAB: [0x1ede050]: add entry: tmpfs /sys/fs/cgroup
65: libmount:      TAB: [0x1ede050]: add entry: cgroup /sys/fs/cgroup/perf_event
65: libmount:      TAB: [0x1ede050]: add entry: cgroup /sys/fs/cgroup/net_cls
65: libmount:      TAB: [0x1ede050]: add entry: cgroup /sys/fs/cgroup/blkio
65: libmount:      TAB: [0x1ede050]: add entry: cgroup /sys/fs/cgroup/memory
65: libmount:      TAB: [0x1ede050]: add entry: cgroup /sys/fs/cgroup/pids
65: libmount:      TAB: [0x1ede050]: add entry: cgroup /sys/fs/cgroup/cpuset
65: libmount:      TAB: [0x1ede050]: add entry: cgroup /sys/fs/cgroup/freezer
65: libmount:      TAB: [0x1ede050]: add entry: cgroup /sys/fs/cgroup/cpu,cpuacct
65: libmount:      TAB: [0x1ede050]: add entry: cgroup /sys/fs/cgroup/devices
65: libmount:      TAB: [0x1ede050]: add entry: cgroup /sys/fs/cgroup/systemd
65: libmount:      TAB: [0x1ede050]: add entry: tmpfs /proc/sys/kernel/random/boot_id
65: libmount:      TAB: [0x1ede050]: add entry: tmpfs /proc/sys/kernel/random/boot_id
65: libmount:      TAB: [0x1ede050]: add entry: tmpfs /proc/kmsg
65: libmount:      TAB: [0x1ede050]: add entry: mqueue /dev/mqueue
65: libmount:      TAB: [0x1ede050]: add entry: hugetlbfs /dev/hugepages
65: libmount:      TAB: [0x1ede050]: add entry: tmpfs /run/user/0
65: libmount:       FS: [0x1ee5200]: free [refcount=0]
65: libmount:      TAB: [0x1ede050]: /proc/self/mountinfo: stop parsing (29 entries)
65: libmount:      TAB: [0x1ede050]: parsing done [filename=/proc/self/mountinfo, rc=0]
65: libmount:    CACHE: [0x1ee40f0]: alloc
65: libmount:      TAB: [0x1ede050]: lookup root fs
65: libmount:      TAB: [0x1ede050]: lookup next child of '/sys/fs/cgroup/perf_event'
65: libmount:      TAB: [0x1ede050]: reset
65: libmount:       FS: [0x1ede2e0]: free [refcount=0]
65: libmount:       FS: [0x1edeb10]: free [refcount=0]
65: libmount:       FS: [0x1edee90]: free [refcount=0]
65: libmount:       FS: [0x1edf210]: free [refcount=0]
65: libmount:       FS: [0x1edf590]: free [refcount=0]
65: libmount:       FS: [0x1edf910]: free [refcount=0]
65: libmount:       FS: [0x1edfd90]: free [refcount=0]
65: libmount:       FS: [0x1ee0110]: free [refcount=0]
65: libmount:       FS: [0x1ee0490]: free [refcount=0]
65: libmount:       FS: [0x1ee0850]: free [refcount=0]
65: libmount:       FS: [0x1ee0c20]: free [refcount=0]
65: libmount:       FS: [0x1ee0ff0]: free [refcount=0]
65: libmount:       FS: [0x1ee13c0]: free [refcount=0]
65: libmount:       FS: [0x1ee1790]: free [refcount=0]
65: libmount:       FS: [0x1ee1b30]: free [refcount=0]
65: libmount:       FS: [0x1ee1ed0]: free [refcount=0]
65: libmount:       FS: [0x1ee2270]: free [refcount=0]
65: libmount:       FS: [0x1ee2610]: free [refcount=0]
65: libmount:       FS: [0x1ee29b0]: free [refcount=0]
65: libmount:       FS: [0x1ee2d50]: free [refcount=0]
65: libmount:       FS: [0x1ee30f0]: free [refcount=0]
65: libmount:       FS: [0x1ee3490]: free [refcount=0]
65: libmount:       FS: [0x1ee3830]: free [refcount=0]
65: libmount:       FS: [0x1ee3bd0]: free [refcount=0]
65: libmount:       FS: [0x1ee3f70]: free [refcount=0]
65: libmount:       FS: [0x1ee4310]: free [refcount=0]
65: libmount:       FS: [0x1ee46e0]: free [refcount=0]
65: libmount:       FS: [0x1ee4aa0]: free [refcount=0]
65: libmount:       FS: [0x1ee4e60]: free [refcount=0]
65: libmount:      TAB: [0x1ede050]: free [refcount=0]
65: libmount:    CACHE: [0x1ee40f0]: free [refcount=0]
TARGET                    SOURCE FSTYPE OPTIONS
/sys/fs/cgroup/perf_event cgroup cgroup ro,nosuid,nodev,noexec,relatime,perf_event

