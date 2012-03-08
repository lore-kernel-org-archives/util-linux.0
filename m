Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41283 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755252Ab2CHJXq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Mar 2012 04:23:46 -0500
Date: Thu, 8 Mar 2012 10:23:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Matt Burgess <matthew@linuxfromscratch.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount -f regression in v2.21's new-mount
Message-ID: <20120308092342.GC28628@x2.net.home>
References: <1331073821.1882.16.camel@kyoto.localdomain>
 <20120307074933.GE8389@x2.net.home>
 <1331158201.1910.1.camel@kyoto.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331158201.1910.1.camel@kyoto.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 07, 2012 at 10:10:01PM +0000, Matt Burgess wrote:
> On Wed, 2012-03-07 at 08:49 +0100, Karel Zak wrote:
> 
> >  Try to modify your init scripts:
> > 
> >     LIBMOUNT_DEBUG=0xffff mount -f /run 2> /root/mount-run.debug
> > 
> >  we will see more details in the log.
> 
> Thanks, Karel.  Debug log attached.

.. but it seems like debug output from the situation when mount(2)
was not called. I don't see any bug here.

    Karel

> 
> Regards,
> 
> Matt.

> 243: libmount:      CXT: [0x178f060]: ----> allocate 
> 243: libmount:    UTILS: mtab: /etc/mtab
> 243: libmount:      CXT: [0x178f060]: enabling flag 0004
> 243: libmount:      CXT: [0x178f060]: mount: preparing
> 243: libmount:      CXT: [0x178f060]: use default optmode
> 243: libmount:      CXT: [0x178f060]: OPTSMODE: ignore=0, append=0, prepend=1, replace=0, force=0, fstab=1, mtab=1
> 243: libmount:      CXT: [0x178f060]: trying to apply fstab (src=(null), target=/run)
> 243: libmount:      TAB: [0x178f200]: alloc
> 243: libmount:      TAB: [0x178f200]: /etc/fstab: start parsing (0 entries)
> 243: libmount:      TAB: [0x178f200]: add entry: /dev/sda3 /
> 243: libmount:      TAB: [0x178f200]: add entry: /dev/sda5 swap
> 243: libmount:      TAB: [0x178f200]: add entry: proc /proc
> 243: libmount:      TAB: [0x178f200]: add entry: sysfs /sys
> 243: libmount:      TAB: [0x178f200]: add entry: devpts /dev/pts
> 243: libmount:      TAB: [0x178f200]: add entry: tmpfs /run
> 243: libmount:      TAB: [0x178f200]: add entry: devtmpfs /dev
> 243: libmount:      TAB: [0x178f200]: /etc/fstab: stop parsing (7 entries)
> 243: libmount:    CACHE: [0x1790480]: alloc
> 243: libmount:      TAB: [0x178f200]: lookup TARGET: /run
> 243: libmount:      CXT: [0x178f060]: apply entry:
> 243: libmount:      CXT: ------ fs: 0x17900f0
> source: tmpfs
> target: /run
> fstype: tmpfs
> optstr: defaults
> 243: libmount:      CXT: [0x178f060]: merging mount flags
> 243: libmount:      CXT: [0x178f060]: final flags: VFS=00000000 user=00000000
> 243: libmount:      CXT: [0x178f060]: mount: evaluating permissions
> 243: libmount:      CXT: [0x178f060]: mount: fixing optstr
> 243: libmount:      CXT: applying 0x00000000 flags to '(null)'
> 243: libmount:      CXT: new optstr 'rw'
> 243: libmount:      CXT: applying 0x00000000 flags to '(null)'
> 243: libmount:      CXT: new optstr '(null)'
> 243: libmount:      CXT: [0x178f060]: fixed options [rc=0]: vfs: 'rw' fs: '(null)' user: '(null)', optstr: 'rw'
> 243: libmount:      CXT: [0x178f060]: preparing source path
> 243: libmount:      CXT: [0x178f060]: srcpath 'tmpfs'
> 243: libmount:      CXT: [0x178f060]: PROPAGATION/pseudo FS source: tmpfs
> 243: libmount:      CXT: [0x178f060]: preparing target path
> 243: libmount:    CACHE: [0x1790480]: add entry [ 1] (path): /run: /run
> 243: libmount:      CXT: [0x178f060]: final target '/run'
> 243: libmount:      CXT: [0x178f060]: FS type: tmpfs
> 243: libmount:      CXT: [0x178f060]: /sbin/mount.tmpfs         ... not found
> 243: libmount:      CXT: [0x178f060]: /sbin/fs.d/mount.tmpfs    ... not found
> 243: libmount:      CXT: [0x178f060]: /sbin/fs/mount.tmpfs      ... not found
> 243: libmount:      CXT: [0x178f060]: prepare update
> 243: libmount:   UPDATE: [0x1790220]: allocate
> 243: libmount:   UPDATE: [0x1790220]: resetting FS [fs=0x0x178f140, target=(null), flags=0x00000000]
> 243: libmount:   UPDATE: [0x1790220]: FS template:
> 243: libmount:   UPDATE: ------ fs: 0x178f140
> source: tmpfs
> target: /run
> fstype: tmpfs
> optstr: rw
> VFS-optstr: rw
> 243: libmount:   UPDATE: [0x1790220]: ready
> 243: libmount:      CXT: [0x178f060]: mount: do mount
> 243: libmount:      CXT: [0x178f060]: (FAKE) mount(2) [source=tmpfs, target=/run, type=tmpfs,  mountflags=0xc0ed0000, mountdata=<none>]
> 243: libmount:   UPDATE: [0x1790220]: /etc/mtab: update tab
> 243: libmount:   UPDATE: ------ fs: 0x17904f0
> source: tmpfs
> target: /run
> fstype: tmpfs
> optstr: rw
> VFS-optstr: rw
> 243: libmount:    LOCKS: [0x178f2c0]: alloc: default linkfile=/etc/mtab~.243, lockfile=/etc/mtab~
> 243: libmount:    LOCKS: [0x178f2c0]: signals: BLOCKED
> 243: libmount:   UPDATE: [0x1790220]: /etc/mtab: add entry
> 243: libmount:    LOCKS: [0x178f2c0]: /etc/mtab~: (243) successfully locked
> 243: libmount:      TAB: [0x1790030]: alloc
> 243: libmount:      TAB: [0x1790030]: /etc/mtab: start parsing (0 entries)
> 243: libmount:      TAB: [0x1790030]: add entry: /dev/sda3 /
> 243: libmount:      TAB: [0x1790030]: add entry: proc /proc
> 243: libmount:      TAB: [0x1790030]: add entry: sysfs /sys
> 243: libmount:      TAB: [0x1790030]: /etc/mtab: stop parsing (3 entries)
> 243: libmount:      TAB: [0x1790030]: add entry: tmpfs /run
> 243: libmount:   UPDATE: [0x1790220]: /etc/mtab: updating
> 243: libmount:    LOCKS: [0x178f2c0]: (243) unlocking
> 243: libmount:    LOCKS: [0x178f2c0]: unlink /etc/mtab~
> 243: libmount:    LOCKS: [0x178f2c0]: restoring sigmask
> 243: libmount:      TAB: [0x1790030]: reset
> 243: libmount:      TAB: [0x1790030]: free
> 243: libmount:   UPDATE: [0x1790220]: /etc/mtab: update tab: done [rc=0]
> 243: libmount:    LOCKS: [0x178f2c0]: free
> 243: libmount:      CXT: [0x178f060]: <---- reset [status=1] ---->
> 243: libmount:      TAB: [0x178f200]: reset
> 243: libmount:      TAB: [0x178f200]: free
> 243: libmount:    CACHE: [0x1790480]: free
> 243: libmount:   UPDATE: [0x1790220]: free
> 243: libmount:      CXT: [0x178f060]: <---- free


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
