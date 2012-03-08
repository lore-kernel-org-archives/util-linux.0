Return-Path: util-linux-owner@vger.kernel.org
Received: from nm8.bullet.mail.ird.yahoo.com ([77.238.189.23]:40834 "HELO
	nm8.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758655Ab2CHUZE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 8 Mar 2012 15:25:04 -0500
Message-ID: <1331238300.1875.2.camel@kyoto.localdomain>
Subject: Re: mount -f regression in v2.21's new-mount
From: Matt Burgess <matthew@linuxfromscratch.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Thu, 08 Mar 2012 20:25:00 +0000
In-Reply-To: <20120308092342.GC28628@x2.net.home>
References: <1331073821.1882.16.camel@kyoto.localdomain>
	 <20120307074933.GE8389@x2.net.home>
	 <1331158201.1910.1.camel@kyoto.localdomain>
	 <20120308092342.GC28628@x2.net.home>
Content-Type: multipart/mixed; boundary="=-33ld+9wdIzl9YHtdm/yT"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-33ld+9wdIzl9YHtdm/yT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-08 at 10:23 +0100, Karel Zak wrote:
> On Wed, Mar 07, 2012 at 10:10:01PM +0000, Matt Burgess wrote:
> > On Wed, 2012-03-07 at 08:49 +0100, Karel Zak wrote:
> > 
> > >  Try to modify your init scripts:
> > > 
> > >     LIBMOUNT_DEBUG=0xffff mount -f /run 2> /root/mount-run.debug
> > > 
> > >  we will see more details in the log.
> > 
> > Thanks, Karel.  Debug log attached.
> 
> .. but it seems like debug output from the situation when mount(2)
> was not called. I don't see any bug here.

Right you are.  My diagnosis was a bit off the other night, but now I've
got a nice simple reproducer for you:

Given the following entry in fstab:

tmpfs          /tmp/run     tmpfs    defaults            0     0

run the following with libmount-enabled mount:

mkdir /tmp/run
mount -n /tmp/run
mount -f /tmp/run
mount -a

It's actually the call to 'mount -a' that causes the overlay of an empty
tmpfs on top of the existing /run mount.

I've attached LIBMOUNT_DEBUG output from the 'mount -a' call that our
bootscript does.  Note how mount correctly detects that /proc, /sys
and /dev are already mounted (although the stderr messages stating as
much are also new as of this version of mount).  It doesn't detect
that /dev/pts is already mounted, but that doesn't appear to impact
anything.  It also doesn't detect that /run is also already mounted,
hence the issue I'm currently seeing.

I can workaround the new stderr messages and the tmpfs being overwritten
by adding 'noauto' to the relevant lines in /etc/fstab, but should this
be required?

Thanks,

Matt.

--=-33ld+9wdIzl9YHtdm/yT
Content-Disposition: attachment; filename="mount-all.debug"
Content-Type: text/plain; name="mount-all.debug"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

239: libmount:      CXT: [0x184f060]: ----> allocate 
239: libmount:    UTILS: mtab: /etc/mtab
239: libmount:      CXT: [0x184f060]: <---- reset [status=0] ---->
239: libmount:      TAB: [0x184f180]: alloc
239: libmount:      TAB: [0x184f180]: /etc/fstab: start parsing (0 entries)
239: libmount:      TAB: [0x184f180]: add entry: /dev/sda3 /
239: libmount:      TAB: [0x184f180]: add entry: /dev/sda5 swap
239: libmount:      TAB: [0x184f180]: add entry: proc /proc
239: libmount:      TAB: [0x184f180]: add entry: sysfs /sys
239: libmount:      TAB: [0x184f180]: add entry: devpts /dev/pts
239: libmount:      TAB: [0x184f180]: add entry: tmpfs /run
239: libmount:      TAB: [0x184f180]: add entry: devtmpfs /dev
239: libmount:      TAB: [0x184f180]: /etc/fstab: stop parsing (7 entries)
239: libmount:    CACHE: [0x1850400]: alloc
239: libmount:      CXT: [0x184f060]: next-mount: trying /
239: libmount:      CXT: [0x184f060]: next-mount: not-match [fstype: ext3, t-pattern: (null), options: defaults, O-pattern: no_netdev]
239: libmount:      CXT: [0x184f060]: <---- reset [status=0] ---->
239: libmount:      CXT: [0x184f060]: next-mount: trying swap
239: libmount:      CXT: [0x184f060]: next-mount: not-match [fstype: swap, t-pattern: (null), options: pri=1, O-pattern: no_netdev]
239: libmount:      CXT: [0x184f060]: <---- reset [status=0] ---->
239: libmount:      CXT: [0x184f060]: next-mount: trying /proc
239: libmount:      TAB: [0x1850390]: alloc
239: libmount:    UTILS: mtab: /etc/mtab
239: libmount:      TAB: [0x1850390]: force /etc/mtab usage
239: libmount:      TAB: [0x1850390]: /etc/mtab: start parsing (0 entries)
239: libmount:      TAB: [0x1850390]: add entry: /dev/sda3 /
239: libmount:      TAB: [0x1850390]: add entry: proc /proc
239: libmount:      TAB: [0x1850390]: add entry: sysfs /sys
239: libmount:      TAB: [0x1850390]: add entry: tmpfs /run
239: libmount:      TAB: [0x1850390]: add entry: devtmpfs /dev
239: libmount:      TAB: [0x1850390]: /etc/mtab: stop parsing (5 entries)
239: libmount:      TAB: lookup fs-root for proc
239: libmount:      TAB: FS root result: /
239: libmount:      CXT: [0x184f060]: enabling flag 8000
239: libmount:      CXT: [0x184f060]: mount: preparing
239: libmount:      CXT: [0x184f060]: use default optmode
239: libmount:      CXT: [0x184f060]: OPTSMODE: ignore=0, append=0, prepend=1, replace=0, force=0, fstab=1, mtab=1
239: libmount:      CXT: [0x184f060]: fstab not required -- skip
239: libmount:      CXT: [0x184f060]: merging mount flags
239: libmount:      CXT: [0x184f060]: final flags: VFS=0000000e user=00000000
239: libmount:      CXT: [0x184f060]: mount: evaluating permissions
239: libmount:      CXT: [0x184f060]: mount: fixing optstr
239: libmount:      CXT: applying 0x00000014 flags to 'nosuid,noexec,nodev'
239: libmount:      CXT: new optstr 'rw,nosuid,noexec,nodev'
239: libmount:      CXT: applying 0x00000000 flags to '(null)'
239: libmount:      CXT: new optstr '(null)'
239: libmount:      CXT: [0x184f060]: fixed options [rc=0]: vfs: 'rw,nosuid,noexec,nodev' fs: '(null)' user: '(null)', optstr: 'rw,nosuid,noexec,nodev'
239: libmount:      CXT: [0x184f060]: preparing source path
239: libmount:      CXT: [0x184f060]: srcpath 'proc'
239: libmount:      CXT: [0x184f060]: PROPAGATION/pseudo FS source: proc
239: libmount:      CXT: [0x184f060]: preparing target path
239: libmount:    CACHE: [0x1850400]: add entry [ 1] (path): /proc: /proc
239: libmount:      CXT: [0x184f060]: final target '/proc'
239: libmount:      CXT: [0x184f060]: FS type: proc
239: libmount:      CXT: [0x184f060]: /sbin/mount.proc          ... not found
239: libmount:      CXT: [0x184f060]: /sbin/fs.d/mount.proc     ... not found
239: libmount:      CXT: [0x184f060]: /sbin/fs/mount.proc       ... not found
239: libmount:      CXT: [0x184f060]: prepare update
239: libmount:   UPDATE: [0x1850000]: allocate
239: libmount:   UPDATE: [0x1850000]: resetting FS [fs=0x0x184f8f0, target=(null), flags=0x0000000e]
239: libmount:   UPDATE: [0x1850000]: FS template:
239: libmount:   UPDATE: ------ fs: 0x184f8f0
source: proc
target: /proc
fstype: proc
optstr: rw,nosuid,noexec,nodev
VFS-optstr: rw,nosuid,noexec,nodev
239: libmount:   UPDATE: [0x1850000]: ready
239: libmount:      CXT: [0x184f060]: mount: do mount
239: libmount:      CXT: [0x184f060]: mount(2) [source=proc, target=/proc, type=proc,  mountflags=0xc0ed000e, mountdata=<none>]
239: libmount:      CXT: [0x184f060]: mount(2) failed [errno=16 Device or resource busy]
mount: proc is already mounted or /proc busy
       proc is already mounted on /proc
239: libmount:      CXT: [0x184f060]: <---- reset [status=0] ---->
239: libmount:      CXT: [0x184f060]: next-mount: trying /sys
239: libmount:      TAB: lookup fs-root for sysfs
239: libmount:      TAB: FS root result: /
239: libmount:      CXT: [0x184f060]: enabling flag 8000
239: libmount:      CXT: [0x184f060]: mount: preparing
239: libmount:      CXT: [0x184f060]: OPTSMODE: ignore=0, append=0, prepend=1, replace=0, force=0, fstab=1, mtab=1
239: libmount:      CXT: [0x184f060]: fstab not required -- skip
239: libmount:      CXT: [0x184f060]: merging mount flags
239: libmount:      CXT: [0x184f060]: final flags: VFS=0000000e user=00000000
239: libmount:      CXT: [0x184f060]: mount: evaluating permissions
239: libmount:      CXT: [0x184f060]: mount: fixing optstr
239: libmount:      CXT: applying 0x00000014 flags to 'nosuid,noexec,nodev'
239: libmount:      CXT: new optstr 'rw,nosuid,noexec,nodev'
239: libmount:      CXT: applying 0x00000000 flags to '(null)'
239: libmount:      CXT: new optstr '(null)'
239: libmount:      CXT: [0x184f060]: fixed options [rc=0]: vfs: 'rw,nosuid,noexec,nodev' fs: '(null)' user: '(null)', optstr: 'rw,nosuid,noexec,nodev'
239: libmount:      CXT: [0x184f060]: preparing source path
239: libmount:      CXT: [0x184f060]: srcpath 'sysfs'
239: libmount:      CXT: [0x184f060]: PROPAGATION/pseudo FS source: sysfs
239: libmount:      CXT: [0x184f060]: preparing target path
239: libmount:    CACHE: [0x1850400]: add entry [ 2] (path): /sys: /sys
239: libmount:      CXT: [0x184f060]: final target '/sys'
239: libmount:      CXT: [0x184f060]: FS type: sysfs
239: libmount:      CXT: [0x184f060]: /sbin/mount.sysfs         ... not found
239: libmount:      CXT: [0x184f060]: /sbin/fs.d/mount.sysfs    ... not found
239: libmount:      CXT: [0x184f060]: /sbin/fs/mount.sysfs      ... not found
239: libmount:      CXT: [0x184f060]: prepare update
239: libmount:   UPDATE: [0x1850000]: resetting FS [fs=0x0x184fb70, target=(null), flags=0x0000000e]
239: libmount:   UPDATE: [0x1850000]: FS template:
239: libmount:   UPDATE: ------ fs: 0x184fb70
source: sysfs
target: /sys
fstype: sysfs
optstr: rw,nosuid,noexec,nodev
VFS-optstr: rw,nosuid,noexec,nodev
239: libmount:   UPDATE: [0x1850000]: ready
239: libmount:      CXT: [0x184f060]: mount: do mount
239: libmount:      CXT: [0x184f060]: mount(2) [source=sysfs, target=/sys, type=sysfs,  mountflags=0xc0ed000e, mountdata=<none>]
239: libmount:      CXT: [0x184f060]: mount(2) failed [errno=16 Device or resource busy]
mount: sysfs is already mounted or /sys busy
       sysfs is already mounted on /sys
239: libmount:      CXT: [0x184f060]: <---- reset [status=0] ---->
239: libmount:      CXT: [0x184f060]: next-mount: trying /dev/pts
239: libmount:      TAB: lookup fs-root for devpts
239: libmount:      TAB: FS root result: /
239: libmount:      CXT: [0x184f060]: enabling flag 8000
239: libmount:      CXT: [0x184f060]: mount: preparing
239: libmount:      CXT: [0x184f060]: OPTSMODE: ignore=0, append=0, prepend=1, replace=0, force=0, fstab=1, mtab=1
239: libmount:      CXT: [0x184f060]: fstab not required -- skip
239: libmount:      CXT: [0x184f060]: merging mount flags
239: libmount:      CXT: [0x184f060]: final flags: VFS=00000000 user=00000000
239: libmount:      CXT: [0x184f060]: mount: evaluating permissions
239: libmount:      CXT: [0x184f060]: mount: fixing optstr
239: libmount:      CXT: applying 0x00000000 flags to '(null)'
239: libmount:      CXT: new optstr 'rw'
239: libmount:      CXT: applying 0x00000000 flags to '(null)'
239: libmount:      CXT: new optstr '(null)'
239: libmount:      CXT: fixing gid
239: libmount:      CXT: [0x184f060]: fixed options [rc=0]: vfs: 'rw' fs: 'gid=4,mode=620' user: '(null)', optstr: 'rw,gid=4,mode=620'
239: libmount:      CXT: [0x184f060]: preparing source path
239: libmount:      CXT: [0x184f060]: srcpath 'devpts'
239: libmount:      CXT: [0x184f060]: PROPAGATION/pseudo FS source: devpts
239: libmount:      CXT: [0x184f060]: preparing target path
239: libmount:    CACHE: [0x1850400]: add entry [ 3] (path): /dev/pts: /dev/pts
239: libmount:      CXT: [0x184f060]: final target '/dev/pts'
239: libmount:      CXT: [0x184f060]: FS type: devpts
239: libmount:      CXT: [0x184f060]: /sbin/mount.devpts        ... not found
239: libmount:      CXT: [0x184f060]: /sbin/fs.d/mount.devpts   ... not found
239: libmount:      CXT: [0x184f060]: /sbin/fs/mount.devpts     ... not found
239: libmount:      CXT: [0x184f060]: prepare update
239: libmount:   UPDATE: [0x1850000]: resetting FS [fs=0x0x184fdf0, target=(null), flags=0x00000000]
239: libmount:   UPDATE: [0x1850000]: FS template:
239: libmount:   UPDATE: ------ fs: 0x184fdf0
source: devpts
target: /dev/pts
fstype: devpts
optstr: rw,gid=4,mode=620
VFS-optstr: rw
FS-opstr: gid=4,mode=620
239: libmount:   UPDATE: [0x1850000]: ready
239: libmount:      CXT: [0x184f060]: mount: do mount
239: libmount:      CXT: [0x184f060]: mount(2) [source=devpts, target=/dev/pts, type=devpts,  mountflags=0xc0ed0000, mountdata=yes]
239: libmount:      CXT: [0x184f060]: mount(2) success
239: libmount:   UPDATE: [0x1850000]: /etc/mtab: update tab
239: libmount:   UPDATE: ------ fs: 0x184f1b0
source: devpts
target: /dev/pts
fstype: devpts
optstr: rw,gid=4,mode=620
VFS-optstr: rw
FS-opstr: gid=4,mode=620
239: libmount:    LOCKS: [0x1851c00]: alloc: default linkfile=/etc/mtab~.239, lockfile=/etc/mtab~
239: libmount:    LOCKS: [0x1851c00]: signals: BLOCKED
239: libmount:   UPDATE: [0x1850000]: /etc/mtab: add entry
239: libmount:    LOCKS: [0x1851c00]: /etc/mtab~: (239) successfully locked
239: libmount:      TAB: [0x18501c0]: alloc
239: libmount:      TAB: [0x18501c0]: /etc/mtab: start parsing (0 entries)
239: libmount:      TAB: [0x18501c0]: add entry: /dev/sda3 /
239: libmount:      TAB: [0x18501c0]: add entry: proc /proc
239: libmount:      TAB: [0x18501c0]: add entry: sysfs /sys
239: libmount:      TAB: [0x18501c0]: add entry: tmpfs /run
239: libmount:      TAB: [0x18501c0]: add entry: devtmpfs /dev
239: libmount:      TAB: [0x18501c0]: /etc/mtab: stop parsing (5 entries)
239: libmount:      TAB: [0x18501c0]: add entry: devpts /dev/pts
239: libmount:   UPDATE: [0x1850000]: /etc/mtab: updating
239: libmount:    LOCKS: [0x1851c00]: (239) unlocking
239: libmount:    LOCKS: [0x1851c00]: unlink /etc/mtab~
239: libmount:    LOCKS: [0x1851c00]: restoring sigmask
239: libmount:      TAB: [0x18501c0]: reset
239: libmount:      TAB: [0x18501c0]: free
239: libmount:   UPDATE: [0x1850000]: /etc/mtab: update tab: done [rc=0]
239: libmount:    LOCKS: [0x1851c00]: free
239: libmount:      CXT: [0x184f060]: <---- reset [status=1] ---->
239: libmount:      CXT: [0x184f060]: next-mount: trying /run
239: libmount:      TAB: lookup fs-root for tmpfs
239: libmount:      TAB: FS root result: /
239: libmount:      CXT: [0x184f060]: enabling flag 8000
239: libmount:      CXT: [0x184f060]: mount: preparing
239: libmount:      CXT: [0x184f060]: OPTSMODE: ignore=0, append=0, prepend=1, replace=0, force=0, fstab=1, mtab=1
239: libmount:      CXT: [0x184f060]: fstab not required -- skip
239: libmount:      CXT: [0x184f060]: merging mount flags
239: libmount:      CXT: [0x184f060]: final flags: VFS=00000000 user=00000000
239: libmount:      CXT: [0x184f060]: mount: evaluating permissions
239: libmount:      CXT: [0x184f060]: mount: fixing optstr
239: libmount:      CXT: applying 0x00000000 flags to '(null)'
239: libmount:      CXT: new optstr 'rw'
239: libmount:      CXT: applying 0x00000000 flags to '(null)'
239: libmount:      CXT: new optstr '(null)'
239: libmount:      CXT: [0x184f060]: fixed options [rc=0]: vfs: 'rw' fs: '(null)' user: '(null)', optstr: 'rw'
239: libmount:      CXT: [0x184f060]: preparing source path
239: libmount:      CXT: [0x184f060]: srcpath 'tmpfs'
239: libmount:      CXT: [0x184f060]: PROPAGATION/pseudo FS source: tmpfs
239: libmount:      CXT: [0x184f060]: preparing target path
239: libmount:    CACHE: [0x1850400]: add entry [ 4] (path): /run: /run
239: libmount:      CXT: [0x184f060]: final target '/run'
239: libmount:      CXT: [0x184f060]: FS type: tmpfs
239: libmount:      CXT: [0x184f060]: /sbin/mount.tmpfs         ... not found
239: libmount:      CXT: [0x184f060]: /sbin/fs.d/mount.tmpfs    ... not found
239: libmount:      CXT: [0x184f060]: /sbin/fs/mount.tmpfs      ... not found
239: libmount:      CXT: [0x184f060]: prepare update
239: libmount:   UPDATE: [0x1850000]: resetting FS [fs=0x0x1850070, target=(null), flags=0x00000000]
239: libmount:   UPDATE: [0x1850000]: FS template:
239: libmount:   UPDATE: ------ fs: 0x1850070
source: tmpfs
target: /run
fstype: tmpfs
optstr: rw
VFS-optstr: rw
239: libmount:   UPDATE: [0x1850000]: ready
239: libmount:      CXT: [0x184f060]: mount: do mount
239: libmount:      CXT: [0x184f060]: mount(2) [source=tmpfs, target=/run, type=tmpfs,  mountflags=0xc0ed0000, mountdata=<none>]
239: libmount:      CXT: [0x184f060]: mount(2) success
239: libmount:   UPDATE: [0x1850000]: /etc/mtab: update tab
239: libmount:   UPDATE: ------ fs: 0x184f1b0
source: tmpfs
target: /run
fstype: tmpfs
optstr: rw
VFS-optstr: rw
239: libmount:    LOCKS: [0x1851e90]: alloc: default linkfile=/etc/mtab~.239, lockfile=/etc/mtab~
239: libmount:    LOCKS: [0x1851e90]: signals: BLOCKED
239: libmount:   UPDATE: [0x1850000]: /etc/mtab: add entry
239: libmount:    LOCKS: [0x1851e90]: /etc/mtab~: (239) successfully locked
239: libmount:      TAB: [0x184ff40]: alloc
239: libmount:      TAB: [0x184ff40]: /etc/mtab: start parsing (0 entries)
239: libmount:      TAB: [0x184ff40]: add entry: /dev/sda3 /
239: libmount:      TAB: [0x184ff40]: add entry: proc /proc
239: libmount:      TAB: [0x184ff40]: add entry: sysfs /sys
239: libmount:      TAB: [0x184ff40]: add entry: tmpfs /run
239: libmount:      TAB: [0x184ff40]: add entry: devtmpfs /dev
239: libmount:      TAB: [0x184ff40]: add entry: devpts /dev/pts
239: libmount:      TAB: [0x184ff40]: /etc/mtab: stop parsing (6 entries)
239: libmount:      TAB: [0x184ff40]: add entry: tmpfs /run
239: libmount:   UPDATE: [0x1850000]: /etc/mtab: updating
239: libmount:    LOCKS: [0x1851e90]: (239) unlocking
239: libmount:    LOCKS: [0x1851e90]: unlink /etc/mtab~
239: libmount:    LOCKS: [0x1851e90]: restoring sigmask
239: libmount:      TAB: [0x184ff40]: reset
239: libmount:      TAB: [0x184ff40]: free
239: libmount:   UPDATE: [0x1850000]: /etc/mtab: update tab: done [rc=0]
239: libmount:    LOCKS: [0x1851e90]: free
239: libmount:      CXT: [0x184f060]: <---- reset [status=1] ---->
239: libmount:      CXT: [0x184f060]: next-mount: trying /dev
239: libmount:      TAB: lookup fs-root for devtmpfs
239: libmount:      TAB: FS root result: /
239: libmount:      CXT: [0x184f060]: enabling flag 8000
239: libmount:      CXT: [0x184f060]: mount: preparing
239: libmount:      CXT: [0x184f060]: OPTSMODE: ignore=0, append=0, prepend=1, replace=0, force=0, fstab=1, mtab=1
239: libmount:      CXT: [0x184f060]: fstab not required -- skip
239: libmount:      CXT: [0x184f060]: merging mount flags
239: libmount:      CXT: [0x184f060]: final flags: VFS=00000002 user=00000000
239: libmount:      CXT: [0x184f060]: mount: evaluating permissions
239: libmount:      CXT: [0x184f060]: mount: fixing optstr
239: libmount:      CXT: applying 0x00000002 flags to 'nosuid'
239: libmount:      CXT: new optstr 'rw,nosuid'
239: libmount:      CXT: applying 0x00000000 flags to '(null)'
239: libmount:      CXT: new optstr '(null)'
239: libmount:      CXT: [0x184f060]: fixed options [rc=0]: vfs: 'rw,nosuid' fs: 'mode=0755' user: '(null)', optstr: 'rw,nosuid,mode=0755'
239: libmount:      CXT: [0x184f060]: preparing source path
239: libmount:      CXT: [0x184f060]: srcpath 'devtmpfs'
239: libmount:      CXT: [0x184f060]: PROPAGATION/pseudo FS source: devtmpfs
239: libmount:      CXT: [0x184f060]: preparing target path
239: libmount:    CACHE: [0x1850400]: add entry [ 5] (path): /dev: /dev
239: libmount:      CXT: [0x184f060]: final target '/dev'
239: libmount:      CXT: [0x184f060]: FS type: devtmpfs
239: libmount:      CXT: [0x184f060]: /sbin/mount.devtmpfs      ... not found
239: libmount:      CXT: [0x184f060]: /sbin/fs.d/mount.devtmpfs ... not found
239: libmount:      CXT: [0x184f060]: /sbin/fs/mount.devtmpfs   ... not found
239: libmount:      CXT: [0x184f060]: prepare update
239: libmount:   UPDATE: [0x1850000]: resetting FS [fs=0x0x18502d0, target=(null), flags=0x00000002]
239: libmount:   UPDATE: [0x1850000]: FS template:
239: libmount:   UPDATE: ------ fs: 0x18502d0
source: devtmpfs
target: /dev
fstype: devtmpfs
optstr: rw,nosuid,mode=0755
VFS-optstr: rw,nosuid
FS-opstr: mode=0755
239: libmount:   UPDATE: [0x1850000]: ready
239: libmount:      CXT: [0x184f060]: mount: do mount
239: libmount:      CXT: [0x184f060]: mount(2) [source=devtmpfs, target=/dev, type=devtmpfs,  mountflags=0xc0ed0002, mountdata=yes]
239: libmount:      CXT: [0x184f060]: mount(2) failed [errno=16 Device or resource busy]
mount: devtmpfs is already mounted or /dev busy
       devtmpfs is already mounted on /dev
239: libmount:      CXT: [0x184f060]: <---- reset [status=0] ---->
239: libmount:      CXT: [0x184f060]: <---- reset [status=0] ---->
239: libmount:      TAB: [0x1850390]: reset
239: libmount:      TAB: [0x1850390]: free
239: libmount:      TAB: [0x184f180]: reset
239: libmount:      TAB: [0x184f180]: free
239: libmount:    CACHE: [0x1850400]: free
239: libmount:   UPDATE: [0x1850000]: free
239: libmount:      CXT: [0x184f060]: <---- free

--=-33ld+9wdIzl9YHtdm/yT--

