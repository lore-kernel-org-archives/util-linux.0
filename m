Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:54895 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbcBOLmS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Feb 2016 06:42:18 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH] tests: add test for loop option in fstab
Date: Mon, 15 Feb 2016 12:42:10 +0100
Cc: util-linux@vger.kernel.org
References: <56BCE4F4.6020409@suse.cz>
In-Reply-To: <56BCE4F4.6020409@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <201602151242.10369.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 11 February 2016, Stanislav Brabec wrote:
> Add a new fstab tests which check loop mount of the same source
> multiple times in multiple steps.

This test still fails if /etc/mtab is a regular file. The second mount 
does mount the image file again but returns with error and warning:
lt-mount: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img 
is already mounted
ret: 64

Could we fix that in libmount or should we skip the test in case of 
non-symlink /etc/mtab?

Here the full debug output of the second mount command:

xxxx: libmount:     INIT: library debug mask: 0xffff
xxxx: libmount:     INIT: library version: 2.26.0
xxxx: libmount:     INIT:     feature: btrfs
xxxx: libmount:     INIT:     feature: assert
xxxx: libmount:     INIT:     feature: debug
Available "LIBMOUNT_DEBUG=<name>[,...]|<mask>" debug masks:
   all      [0xffff] : info about all subsystems
   cache    [0xffff] : paths and tags cache
   cxt      [0xffff] : library context (handler)
   diff     [0xffff] : mountinfo changes tracking
   fs       [0xffff] : FS abstraction
   help     [0xffff] : this help
   locks    [0xffff] : mtab and utab locking
   options  [0xffff] : mount options parsing
   tab      [0xffff] : fstab, mtab, mounninfo routines
   update   [0xffff] : mtab, utab updates
   utils    [0xffff] : misc library utils
   monitor  [0xffff] : mount tables monitor
   btrfs    [0xffff] : btrfs specific routines
xxxx: libmount:      CXT: [0xffff]: ----> allocate 
xxxx: libmount:      CXT: [0xffff]: <---- reset [status=0] ---->
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:      TAB: [0xffff]: alloc
xxxx: libmount:    CACHE: [0xffff]: alloc
xxxx: libmount:      TAB: [0xffff]: /etc/fstab: start parsing 
[entries=0, filter=not]
xxxx: libmount:      TAB: [0xffff]: add entry: LABEL=cloudimg-rootfs /
xxxx: libmount:      TAB: [0xffff]: add entry: /dev/null /var/ramfs
xxxx: libmount:      TAB: [0xffff]: add 
entry: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-1
xxxx: libmount:      TAB: [0xffff]: add 
entry: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:      TAB: [0xffff]: /etc/fstab: stop parsing (4 entries)
xxxx: libmount:      TAB: [0xffff]: parsing done [filename=/etc/fstab, 
rc=0]
xxxx: libmount:      CXT: [0xffff]: next-mount: trying /
xxxx: libmount:      CXT: [0xffff]: next-mount: not-match [fstype: ext4, 
t-pattern: (null), options: defaults, O-pattern: (null)]
xxxx: libmount:      CXT: [0xffff]: <---- reset [status=0] ---->
xxxx: libmount:      CXT: [0xffff]: next-mount: trying /var/ramfs
xxxx: libmount:      TAB: [0xffff]: alloc
xxxx: libmount:    UTILS: mtab: /etc/mtab
xxxx: libmount:      TAB: [0xffff]: force mtab usage 
[filename=/etc/mtab]
xxxx: libmount:      TAB: [0xffff]: /etc/mtab: start parsing [entries=0, 
filter=not]
xxxx: libmount:      TAB: trying to guess table type
xxxx: libmount:      TAB: [0xffff]: add entry: /dev/sda1 /
xxxx: libmount:      TAB: [0xffff]: add entry: proc /proc
xxxx: libmount:      TAB: [0xffff]: add entry: sysfs /sys
xxxx: libmount:      TAB: [0xffff]: add entry: none /sys/fs/cgroup
xxxx: libmount:      TAB: [0xffff]: add entry: 
none /sys/fs/fuse/connections
xxxx: libmount:      TAB: [0xffff]: add entry: none /sys/kernel/debug
xxxx: libmount:      TAB: [0xffff]: add entry: none /sys/kernel/security
xxxx: libmount:      TAB: [0xffff]: add entry: udev /dev
xxxx: libmount:      TAB: [0xffff]: add entry: devpts /dev/pts
xxxx: libmount:      TAB: [0xffff]: add entry: tmpfs /run
xxxx: libmount:      TAB: [0xffff]: add entry: none /run/lock
xxxx: libmount:      TAB: [0xffff]: add entry: none /run/shm
xxxx: libmount:      TAB: [0xffff]: add entry: none /run/user
xxxx: libmount:      TAB: [0xffff]: add entry: none /sys/fs/pstore
xxxx: libmount:      TAB: [0xffff]: add entry: /dev/null /var/ramfs
xxxx: libmount:      TAB: [0xffff]: add entry: 
cgroup /sys/fs/cgroup/cpuset
xxxx: libmount:      TAB: [0xffff]: add entry: cgroup /sys/fs/cgroup/cpu
xxxx: libmount:      TAB: [0xffff]: add entry: 
binfmt_misc /proc/sys/fs/binfmt_misc
xxxx: libmount:      TAB: [0xffff]: add entry: 
systemd /sys/fs/cgroup/systemd
xxxx: libmount:      TAB: [0xffff]: add 
entry: /dev/loop0 /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-1
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:      TAB: [0xffff]: /etc/mtab: stop parsing (20 entries)
xxxx: libmount:      TAB: [0xffff]: parsing done [filename=/etc/mtab, 
rc=0]
xxxx: libmount:      CXT: [0xffff]: mtab requested [nents=20]
xxxx: libmount:       FS: [0xffff]: is FS mounted? [target=/var/ramfs, 
source=/dev/null]
xxxx: libmount:       FS: [0xffff]: is mounted: src=/dev/null, 
tgt=/var/ramfs, root=(null)
xxxx: libmount:      TAB: [0xffff]: mnt_table_is_fs_mounted: /dev/null 
[rc=1]
xxxx: libmount:      CXT: [0xffff]: <---- reset [status=0] ---->
xxxx: libmount:      CXT: [0xffff]: next-mount: 
trying /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-1
xxxx: libmount:      CXT: [0xffff]: mtab requested [nents=20]
xxxx: libmount:       FS: [0xffff]: is FS mounted? 
[target=/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-1, 
source=/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img]
xxxx: libmount:    CACHE: [0xffff]: canonicalize 
path /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img
xxxx: libmount:    CACHE: [0xffff]: add entry [ 1] 
(path): /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img
xxxx: libmount:       FS: [0xffff]: is mounted: 
src=/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img, 
tgt=/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-1, 
root=(null)
xxxx: libmount:      TAB: [0xffff]: 
mnt_table_is_fs_mounted: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img 
[rc=0]
xxxx: libmount:      CXT: [0xffff]: mount: preparing
xxxx: libmount:      CXT: [0xffff]: use default optsmode
xxxx: libmount:      CXT: [0xffff]: OPTSMODE: ignore=0, append=0, 
prepend=1, replace=0, force=0, fstab=1, mtab=1
xxxx: libmount:      CXT: [0xffff]: fstab not required -- skip
xxxx: libmount:      CXT: [0xffff]: merging mount flags
xxxx: libmount:      CXT: [0xffff]: final flags: VFS=00000000 
user=00000200
xxxx: libmount:      CXT: [0xffff]: mount: evaluating permissions
xxxx: libmount:      CXT: [0xffff]: mount: fixing optstr
xxxx: libmount:      CXT: [0xffff]: mount: fixing vfs optstr
xxxx: libmount:      CXT: applying 0x00000000 flags to '(null)'
xxxx: libmount:      CXT: new optstr 'rw'
xxxx: libmount:      CXT: [0xffff]: mount: fixing user optstr
xxxx: libmount:      CXT: applying 0x00000512 flags to 'loop'
xxxx: libmount:      CXT: new optstr 'loop'
xxxx: libmount:      CXT: [0xffff]: fixed options [rc=0]: vfs: 'rw' 
fs: '(null)' user: 'loop', optstr: 'rw,loop'
xxxx: libmount:      CXT: [0xffff]: preparing source path
xxxx: libmount:      CXT: [0xffff]: 
srcpath '/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img'
xxxx: libmount:      CXT: [0xffff]: loopdev specific options detected
xxxx: libmount:      CXT: [0xffff]: trying to setup loopdev 
for /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img
xxxx: libmount:      CXT: [0xffff]: mtab requested [nents=20]
xxxx: libmount:      CXT: [0xffff]: checking 
if /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img 
mounted 
on /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-1
xxxx: libmount:      CXT: 
[0xffff]: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img 
already mounted
xxxx: libmount:      CXT: [0xffff]: mount: preparing failed
lt-mount: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img 
is already mounted
xxxx: libmount:      CXT: [0xffff]: <---- reset [status=0] ---->
xxxx: libmount:      CXT: [0xffff]: next-mount: 
trying /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2
xxxx: libmount:      CXT: [0xffff]: mtab requested [nents=20]
xxxx: libmount:       FS: [0xffff]: is FS mounted? 
[target=/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2, 
source=/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img]
xxxx: libmount:       FS: [0xffff]: is mounted: 
src=/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img, 
tgt=/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2, 
root=(null)
xxxx: libmount:      TAB: [0xffff]: 
mnt_table_is_fs_mounted: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img 
[rc=0]
xxxx: libmount:      CXT: [0xffff]: mount: preparing
xxxx: libmount:      CXT: [0xffff]: OPTSMODE: ignore=0, append=0, 
prepend=1, replace=0, force=0, fstab=1, mtab=1
xxxx: libmount:      CXT: [0xffff]: fstab not required -- skip
xxxx: libmount:      CXT: [0xffff]: merging mount flags
xxxx: libmount:      CXT: [0xffff]: final flags: VFS=00000000 
user=00000200
xxxx: libmount:      CXT: [0xffff]: mount: evaluating permissions
xxxx: libmount:      CXT: [0xffff]: mount: fixing optstr
xxxx: libmount:      CXT: [0xffff]: mount: fixing vfs optstr
xxxx: libmount:      CXT: applying 0x00000000 flags to '(null)'
xxxx: libmount:      CXT: new optstr 'rw'
xxxx: libmount:      CXT: [0xffff]: mount: fixing user optstr
xxxx: libmount:      CXT: applying 0x00000512 flags to 'loop'
xxxx: libmount:      CXT: new optstr 'loop'
xxxx: libmount:      CXT: [0xffff]: fixed options [rc=0]: vfs: 'rw' 
fs: '(null)' user: 'loop', optstr: 'rw,loop'
xxxx: libmount:      CXT: [0xffff]: preparing source path
xxxx: libmount:      CXT: [0xffff]: 
srcpath '/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img'
xxxx: libmount:      CXT: [0xffff]: loopdev specific options detected
xxxx: libmount:      CXT: [0xffff]: trying to setup loopdev 
for /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img
xxxx: libmount:      CXT: [0xffff]: mtab requested [nents=20]
xxxx: libmount:      CXT: [0xffff]: checking 
if /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop.img 
mounted 
on /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2
xxxx: libmount:    CACHE: [0xffff]: canonicalize 
path /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2
xxxx: libmount:    CACHE: [0xffff]: add entry [ 2] 
(path): /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2
xxxx: libmount:    CACHE: [0xffff]: canonicalize 
path /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-1
xxxx: libmount:    CACHE: [0xffff]: add entry [ 3] 
(path): /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-1: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-1
xxxx: libmount:    CACHE: [0xffff]: canonicalize 
path /sys/fs/cgroup/systemd
xxxx: libmount:    CACHE: [0xffff]: add entry [ 4] 
(path): /sys/fs/cgroup/systemd: /sys/fs/cgroup/systemd
xxxx: libmount:    CACHE: [0xffff]: canonicalize 
path /proc/sys/fs/binfmt_misc
xxxx: libmount:    CACHE: [0xffff]: add entry [ 5] 
(path): /proc/sys/fs/binfmt_misc: /proc/sys/fs/binfmt_misc
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /sys/fs/cgroup/cpu
xxxx: libmount:    CACHE: [0xffff]: add entry [ 6] 
(path): /sys/fs/cgroup/cpu: /sys/fs/cgroup/cpu
xxxx: libmount:    CACHE: [0xffff]: canonicalize 
path /sys/fs/cgroup/cpuset
xxxx: libmount:    CACHE: [0xffff]: add entry [ 7] 
(path): /sys/fs/cgroup/cpuset: /sys/fs/cgroup/cpuset
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /var/ramfs
xxxx: libmount:    CACHE: [0xffff]: add entry [ 8] 
(path): /var/ramfs: /var/ramfs
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /sys/fs/pstore
xxxx: libmount:    CACHE: [0xffff]: add entry [ 9] 
(path): /sys/fs/pstore: /sys/fs/pstore
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /run/user
xxxx: libmount:    CACHE: [0xffff]: add entry [10] 
(path): /run/user: /run/user
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /run/shm
xxxx: libmount:    CACHE: [0xffff]: add entry [11] 
(path): /run/shm: /run/shm
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /run/lock
xxxx: libmount:    CACHE: [0xffff]: add entry [12] 
(path): /run/lock: /run/lock
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /run
xxxx: libmount:    CACHE: [0xffff]: add entry [13] (path): /run: /run
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /dev/pts
xxxx: libmount:    CACHE: [0xffff]: add entry [14] 
(path): /dev/pts: /dev/pts
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /dev
xxxx: libmount:    CACHE: [0xffff]: add entry [15] (path): /dev: /dev
xxxx: libmount:    CACHE: [0xffff]: canonicalize 
path /sys/kernel/security
xxxx: libmount:    CACHE: [0xffff]: add entry [16] 
(path): /sys/kernel/security: /sys/kernel/security
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /sys/kernel/debug
xxxx: libmount:    CACHE: [0xffff]: add entry [17] 
(path): /sys/kernel/debug: /sys/kernel/debug
xxxx: libmount:    CACHE: [0xffff]: canonicalize 
path /sys/fs/fuse/connections
xxxx: libmount:    CACHE: [0xffff]: add entry [18] 
(path): /sys/fs/fuse/connections: /sys/fs/fuse/connections
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /sys/fs/cgroup
xxxx: libmount:    CACHE: [0xffff]: add entry [19] 
(path): /sys/fs/cgroup: /sys/fs/cgroup
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /sys
xxxx: libmount:    CACHE: [0xffff]: add entry [20] (path): /sys: /sys
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /proc
xxxx: libmount:    CACHE: [0xffff]: add entry [21] (path): /proc: /proc
xxxx: libmount:    CACHE: [0xffff]: canonicalize path /
xxxx: libmount:    CACHE: [0xffff]: add entry [22] (path): /: /
xxxx: libmount:      CXT: [0xffff]: enabling AUTOCLEAR flag
xxxx: libmount:      CXT: [0xffff]: trying to use /dev/loop1
xxxx: libmount:      CXT: [0xffff]: final srcpath '/dev/loop1'
xxxx: libmount:      CXT: [0xffff]: preparing target path
xxxx: libmount:      CXT: [0xffff]: final 
target '/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2'
xxxx: libmount:      CXT: [0xffff]: preparing fstype
xxxx: libmount:      CXT: [0xffff]: FS type: ext3 [rc=0]
xxxx: libmount:      CXT: [0xffff]: /sbin/mount.ext3          ... not 
found
xxxx: libmount:      CXT: [0xffff]: /sbin/fs.d/mount.ext3     ... not 
found
xxxx: libmount:      CXT: [0xffff]: /sbin/fs/mount.ext3       ... not 
found
xxxx: libmount:      CXT: [0xffff]: prepare update
xxxx: libmount:      CXT: [0xffff]: checking for writable tab files
xxxx: libmount:    UTILS: mtab: /etc/mtab
xxxx: libmount:   UPDATE: [0xffff]: allocate
xxxx: libmount:   UPDATE: [0xffff]: resetting FS [fs=0x0x1466eb0, 
target=(null), flags=0x00000000]
xxxx: libmount:   UPDATE: [0xffff]: FS template:
xxxx: libmount:   UPDATE: ------ fs: 0x1466eb0
source: /dev/loop1
target: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2
fstype: ext3
optstr: rw,loop
VFS-optstr: rw
user-optstr: 
xxxx: libmount:   UPDATE: [0xffff]: ready
xxxx: libmount:      CXT: [0xffff]: mount: do mount
xxxx: libmount:      CXT: [0xffff]: mount(2) [source=/dev/loop1, 
target=/home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2, 
type=ext3,  mountflags=0xc0ed0000, mountdata=<none>]
xxxx: libmount:      CXT: [0xffff]:   success
xxxx: libmount:   UPDATE: [0xffff]: /etc/mtab: update tab
xxxx: libmount:   UPDATE: ------ fs: 0x1466220
source: /dev/loop1
target: /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2
fstype: ext3
optstr: rw
VFS-optstr: rw
xxxx: libmount:    LOCKS: [0xffff]: alloc: default 
linkfile=/etc/mtab~.4089, lockfile=/etc/mtab~
xxxx: libmount:    LOCKS: [0xffff]: signals: BLOCKED
xxxx: libmount:   UPDATE: [0xffff]: /etc/mtab: add entry
xxxx: libmount:    LOCKS: [0xffff]: /etc/mtab~: (4089) successfully 
locked
xxxx: libmount:      TAB: [0xffff]: alloc
xxxx: libmount:      TAB: [0xffff]: /etc/mtab: start parsing [entries=0, 
filter=not]
xxxx: libmount:      TAB: [0xffff]: add entry: /dev/sda1 /
xxxx: libmount:      TAB: [0xffff]: add entry: proc /proc
xxxx: libmount:      TAB: [0xffff]: add entry: sysfs /sys
xxxx: libmount:      TAB: [0xffff]: add entry: none /sys/fs/cgroup
xxxx: libmount:      TAB: [0xffff]: add entry: 
none /sys/fs/fuse/connections
xxxx: libmount:      TAB: [0xffff]: add entry: none /sys/kernel/debug
xxxx: libmount:      TAB: [0xffff]: add entry: none /sys/kernel/security
xxxx: libmount:      TAB: [0xffff]: add entry: udev /dev
xxxx: libmount:      TAB: [0xffff]: add entry: devpts /dev/pts
xxxx: libmount:      TAB: [0xffff]: add entry: tmpfs /run
xxxx: libmount:      TAB: [0xffff]: add entry: none /run/lock
xxxx: libmount:      TAB: [0xffff]: add entry: none /run/shm
xxxx: libmount:      TAB: [0xffff]: add entry: none /run/user
xxxx: libmount:      TAB: [0xffff]: add entry: none /sys/fs/pstore
xxxx: libmount:      TAB: [0xffff]: add entry: /dev/null /var/ramfs
xxxx: libmount:      TAB: [0xffff]: add entry: 
cgroup /sys/fs/cgroup/cpuset
xxxx: libmount:      TAB: [0xffff]: add entry: cgroup /sys/fs/cgroup/cpu
xxxx: libmount:      TAB: [0xffff]: add entry: 
binfmt_misc /proc/sys/fs/binfmt_misc
xxxx: libmount:      TAB: [0xffff]: add entry: 
systemd /sys/fs/cgroup/systemd
xxxx: libmount:      TAB: [0xffff]: add 
entry: /dev/loop0 /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-1
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:      TAB: [0xffff]: /etc/mtab: stop parsing (20 entries)
xxxx: libmount:      TAB: [0xffff]: parsing done [filename=/etc/mtab, 
rc=0]
xxxx: libmount:      TAB: [0xffff]: add 
entry: /dev/loop1 /home/travis/build/rudimeier/util-linux/tests/output/mount/fstab-loop-mnt-2
xxxx: libmount:   UPDATE: [0xffff]: /etc/mtab: updating
xxxx: libmount:    LOCKS: [0xffff]: (4089) unlocking
xxxx: libmount:    LOCKS: [0xffff]: unlink /etc/mtab~
xxxx: libmount:    LOCKS: [0xffff]: restoring sigmask
xxxx: libmount:      TAB: [0xffff]: reset
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:      TAB: [0xffff]: free [refcount=0]
xxxx: libmount:   UPDATE: [0xffff]: /etc/mtab: update tab: done [rc=0]
xxxx: libmount:    LOCKS: [0xffff]: free
xxxx: libmount:      CXT: [0xffff]: <---- reset [status=1] ---->
xxxx: libmount:      CXT: [0xffff]: <---- reset [status=0] ---->
xxxx: libmount:      TAB: [0xffff]: reset
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:      TAB: [0xffff]: free [refcount=0]
xxxx: libmount:      TAB: [0xffff]: reset
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:      TAB: [0xffff]: free [refcount=0]
xxxx: libmount:    CACHE: [0xffff]: free [refcount=0]
xxxx: libmount:      CXT: [0xffff]: closing loopdev FD
xxxx: libmount:   UPDATE: [0xffff]: free
xxxx: libmount:       FS: [0xffff]: free [refcount=0]
xxxx: libmount:      CXT: [0xffff]: <---- free
