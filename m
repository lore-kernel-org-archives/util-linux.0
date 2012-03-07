Return-Path: util-linux-owner@vger.kernel.org
Received: from nm19.bullet.mail.ukl.yahoo.com ([217.146.183.193]:48778 "HELO
	nm19.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030605Ab2CGWQp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 7 Mar 2012 17:16:45 -0500
Message-ID: <1331158201.1910.1.camel@kyoto.localdomain>
Subject: Re: mount -f regression in v2.21's new-mount
From: Matt Burgess <matthew@linuxfromscratch.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Wed, 07 Mar 2012 22:10:01 +0000
In-Reply-To: <20120307074933.GE8389@x2.net.home>
References: <1331073821.1882.16.camel@kyoto.localdomain>
	 <20120307074933.GE8389@x2.net.home>
Content-Type: multipart/mixed; boundary="=-H11D74U+K/xdzjFfJf5j"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-H11D74U+K/xdzjFfJf5j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-03-07 at 08:49 +0100, Karel Zak wrote:

>  Try to modify your init scripts:
> 
>     LIBMOUNT_DEBUG=0xffff mount -f /run 2> /root/mount-run.debug
> 
>  we will see more details in the log.

Thanks, Karel.  Debug log attached.

Regards,

Matt.

--=-H11D74U+K/xdzjFfJf5j
Content-Disposition: attachment; filename="mount-run.debug"
Content-Type: text/plain; name="mount-run.debug"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

243: libmount:      CXT: [0x178f060]: ----> allocate 
243: libmount:    UTILS: mtab: /etc/mtab
243: libmount:      CXT: [0x178f060]: enabling flag 0004
243: libmount:      CXT: [0x178f060]: mount: preparing
243: libmount:      CXT: [0x178f060]: use default optmode
243: libmount:      CXT: [0x178f060]: OPTSMODE: ignore=0, append=0, prepend=1, replace=0, force=0, fstab=1, mtab=1
243: libmount:      CXT: [0x178f060]: trying to apply fstab (src=(null), target=/run)
243: libmount:      TAB: [0x178f200]: alloc
243: libmount:      TAB: [0x178f200]: /etc/fstab: start parsing (0 entries)
243: libmount:      TAB: [0x178f200]: add entry: /dev/sda3 /
243: libmount:      TAB: [0x178f200]: add entry: /dev/sda5 swap
243: libmount:      TAB: [0x178f200]: add entry: proc /proc
243: libmount:      TAB: [0x178f200]: add entry: sysfs /sys
243: libmount:      TAB: [0x178f200]: add entry: devpts /dev/pts
243: libmount:      TAB: [0x178f200]: add entry: tmpfs /run
243: libmount:      TAB: [0x178f200]: add entry: devtmpfs /dev
243: libmount:      TAB: [0x178f200]: /etc/fstab: stop parsing (7 entries)
243: libmount:    CACHE: [0x1790480]: alloc
243: libmount:      TAB: [0x178f200]: lookup TARGET: /run
243: libmount:      CXT: [0x178f060]: apply entry:
243: libmount:      CXT: ------ fs: 0x17900f0
source: tmpfs
target: /run
fstype: tmpfs
optstr: defaults
243: libmount:      CXT: [0x178f060]: merging mount flags
243: libmount:      CXT: [0x178f060]: final flags: VFS=00000000 user=00000000
243: libmount:      CXT: [0x178f060]: mount: evaluating permissions
243: libmount:      CXT: [0x178f060]: mount: fixing optstr
243: libmount:      CXT: applying 0x00000000 flags to '(null)'
243: libmount:      CXT: new optstr 'rw'
243: libmount:      CXT: applying 0x00000000 flags to '(null)'
243: libmount:      CXT: new optstr '(null)'
243: libmount:      CXT: [0x178f060]: fixed options [rc=0]: vfs: 'rw' fs: '(null)' user: '(null)', optstr: 'rw'
243: libmount:      CXT: [0x178f060]: preparing source path
243: libmount:      CXT: [0x178f060]: srcpath 'tmpfs'
243: libmount:      CXT: [0x178f060]: PROPAGATION/pseudo FS source: tmpfs
243: libmount:      CXT: [0x178f060]: preparing target path
243: libmount:    CACHE: [0x1790480]: add entry [ 1] (path): /run: /run
243: libmount:      CXT: [0x178f060]: final target '/run'
243: libmount:      CXT: [0x178f060]: FS type: tmpfs
243: libmount:      CXT: [0x178f060]: /sbin/mount.tmpfs         ... not found
243: libmount:      CXT: [0x178f060]: /sbin/fs.d/mount.tmpfs    ... not found
243: libmount:      CXT: [0x178f060]: /sbin/fs/mount.tmpfs      ... not found
243: libmount:      CXT: [0x178f060]: prepare update
243: libmount:   UPDATE: [0x1790220]: allocate
243: libmount:   UPDATE: [0x1790220]: resetting FS [fs=0x0x178f140, target=(null), flags=0x00000000]
243: libmount:   UPDATE: [0x1790220]: FS template:
243: libmount:   UPDATE: ------ fs: 0x178f140
source: tmpfs
target: /run
fstype: tmpfs
optstr: rw
VFS-optstr: rw
243: libmount:   UPDATE: [0x1790220]: ready
243: libmount:      CXT: [0x178f060]: mount: do mount
243: libmount:      CXT: [0x178f060]: (FAKE) mount(2) [source=tmpfs, target=/run, type=tmpfs,  mountflags=0xc0ed0000, mountdata=<none>]
243: libmount:   UPDATE: [0x1790220]: /etc/mtab: update tab
243: libmount:   UPDATE: ------ fs: 0x17904f0
source: tmpfs
target: /run
fstype: tmpfs
optstr: rw
VFS-optstr: rw
243: libmount:    LOCKS: [0x178f2c0]: alloc: default linkfile=/etc/mtab~.243, lockfile=/etc/mtab~
243: libmount:    LOCKS: [0x178f2c0]: signals: BLOCKED
243: libmount:   UPDATE: [0x1790220]: /etc/mtab: add entry
243: libmount:    LOCKS: [0x178f2c0]: /etc/mtab~: (243) successfully locked
243: libmount:      TAB: [0x1790030]: alloc
243: libmount:      TAB: [0x1790030]: /etc/mtab: start parsing (0 entries)
243: libmount:      TAB: [0x1790030]: add entry: /dev/sda3 /
243: libmount:      TAB: [0x1790030]: add entry: proc /proc
243: libmount:      TAB: [0x1790030]: add entry: sysfs /sys
243: libmount:      TAB: [0x1790030]: /etc/mtab: stop parsing (3 entries)
243: libmount:      TAB: [0x1790030]: add entry: tmpfs /run
243: libmount:   UPDATE: [0x1790220]: /etc/mtab: updating
243: libmount:    LOCKS: [0x178f2c0]: (243) unlocking
243: libmount:    LOCKS: [0x178f2c0]: unlink /etc/mtab~
243: libmount:    LOCKS: [0x178f2c0]: restoring sigmask
243: libmount:      TAB: [0x1790030]: reset
243: libmount:      TAB: [0x1790030]: free
243: libmount:   UPDATE: [0x1790220]: /etc/mtab: update tab: done [rc=0]
243: libmount:    LOCKS: [0x178f2c0]: free
243: libmount:      CXT: [0x178f060]: <---- reset [status=1] ---->
243: libmount:      TAB: [0x178f200]: reset
243: libmount:      TAB: [0x178f200]: free
243: libmount:    CACHE: [0x1790480]: free
243: libmount:   UPDATE: [0x1790220]: free
243: libmount:      CXT: [0x178f060]: <---- free

--=-H11D74U+K/xdzjFfJf5j--

