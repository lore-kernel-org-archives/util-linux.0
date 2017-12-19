Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:58533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762470AbdLSLux (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Dec 2017 06:50:53 -0500
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MMjgF-1eMYmh0B83-008YDj for <util-linux@vger.kernel.org>; Tue, 19 Dec 2017
 12:50:52 +0100
To: util-linux@vger.kernel.org
Subject: Re: v2.31.1 plan
From: Ruediger Meier <sweet_f_a@gmx.de>
Date: Tue, 19 Dec 2017 12:50:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201712191250.51516.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 19 December 2017 at 11:52, you wrote:
> On Fri, Dec 15, 2017 at 01:01:23PM +0100, Rüdiger Meier wrote:
> > On 12/14/2017 04:00 PM, Karel Zak wrote:
> > >   I'd like to release stable maintenance v2.31.1 tomorrow or on
> > > Monday.
> > >
> > >   All is already in stable/v2.31 branch:
> > >   https://github.com/karelzak/util-linux/tree/stable/v2.31
> > >
> > >   See log below, comments & objections?
> >
> > I have one, probably minor issue which I was too lazy to
> > investigate so far.
> >
> > Test mount/fslists-type-pattern fails if you have /sbin/mount.exfat
> > installed.
>
> It sounds strange and I cannot reproduce this problem.
>
> # ls -la /sbin/mount.exfat
> lrwxrwxrwx 1 root root 16 Jun 21 16:27 /sbin/mount.exfat ->
> mount.exfat-fuse
>
> # ./tests/ts/mount/fslists
>         mount: fs lists                       ...
>
>                 : one-type                    ... OK
>                 : more-types                  ... OK
>                 : more-types-fstab            ... OK
>                 : type-pattern                ... OK
>                 : type-pattern-neg            ... OK
>
>            ... OK (all 5 sub-tests PASSED)
>
>
>     Karel


I can reproduce it trying to mount an ext4 device using "-t nofoo,bar"
like in the test, as you see below. I'm not sure whether the bad return 
value of mount.exfat is the problem or why mount is trying mount.exfat
(and friends) at all.


$ sudo LIBMOUNT_DEBUG=0xffff ./mount -t nofoo,bar /dev/vg0/root /mnt/tmp
6682: libmount:     INIT: library debug mask: 0xffff
6682: libmount:     INIT: library version: 2.31.157
6682: libmount:     INIT:     feature: btrfs
6682: libmount:     INIT:     feature: assert
6682: libmount:     INIT:     feature: debug
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
6682: libmount:      CXT: [0x1f00fb0]: ----> allocate
6682: libmount:      CXT: [0x1f00fb0]: mount: preparing
6682: libmount:      CXT: [0x1f00fb0]: use default optsmode
6682: libmount:      CXT: [0x1f00fb0]: OPTSMODE: ignore=0, append=0, 
prepend=1, replace=0, force=0, fstab=1, mtab=1
6682: libmount:      CXT: [0x1f00fb0]: fstab not required -- skip
6682: libmount:      CXT: [0x1f00fb0]: merging mount flags
6682: libmount:      CXT: [0x1f00fb0]: final flags: VFS=00000000 
user=00000000
6682: libmount:      CXT: [0x1f00fb0]: mount: evaluating permissions
6682: libmount:      CXT: [0x1f00fb0]: mount: fixing optstr
6682: libmount:      CXT: [0x1f00fb0]: mount: fixing vfs optstr
6682: libmount:      CXT: applying 0x00000000 flags to '(null)'
6682: libmount:      CXT: new optstr 'rw'
6682: libmount:      CXT: [0x1f00fb0]: mount: fixing user optstr
6682: libmount:      CXT: applying 0x00000000 flags to '(null)'
6682: libmount:      CXT: new optstr '(null)'
6682: libmount:      CXT: [0x1f00fb0]: fixed options [rc=0]: vfs: 'rw' 
fs: '(null)' user: '(null)', optstr: 'rw'
6682: libmount:      CXT: [0x1f00fb0]: preparing source path
6682: libmount:      CXT: [0x1f00fb0]: srcpath '/dev/vg0/root'
6682: libmount:    CACHE: [0x1f01230]: alloc
6682: libmount:    CACHE: [0x1f01230]: canonicalize path /dev/vg0/root
6682: libmount:    CACHE: [0x1f01230]: add entry [ 1] 
(path): /dev/mapper/vg0-root: /dev/vg0/root
6682: libmount:      CXT: [0x1f00fb0]: final 
srcpath '/dev/mapper/vg0-root'
6682: libmount:      CXT: [0x1f00fb0]: preparing target path
6682: libmount:    CACHE: [0x1f01230]: canonicalize path /mnt/tmp
6682: libmount:    CACHE: [0x1f01230]: add entry [ 2] 
(path): /mnt/tmp: /mnt/tmp
6682: libmount:      CXT: [0x1f00fb0]: final target '/mnt/tmp'
6682: libmount:      CXT: [0x1f00fb0]: preparing fstype
6682: libmount:      CXT: [0x1f00fb0]: FS type: (null) [rc=0]
6682: libmount:      CXT: [0x1f00fb0]: prepare update
6682: libmount:      CXT: [0x1f00fb0]: checking for writable tab files
6682: libmount:    UTILS: utab: /run/mount/utab
6682: libmount:    UTILS: try write /run/mount/utab dir: (null)
6682: libmount:    UTILS:  access OK
6682: libmount:   UPDATE: [0x1f01ec0]: allocate
6682: libmount:   UPDATE: [0x1f01ec0]: resetting FS [fs=0x0x1f010b0, 
target=(null), flags=0x00000000]
6682: libmount:   UPDATE: [0x1f01ec0]: FS template:
6682: libmount:   UPDATE: ------ fs: 0x1f010b0
source: /dev/mapper/vg0-root
target: /mnt/tmp
fstype: (null)
optstr: rw
VFS-optstr: rw
6682: libmount:   UPDATE: prepare utab entry
6682: libmount:   UPDATE: utab entry unnecessary (no options)
6682: libmount:      CXT: [0x1f00fb0]: mount: do mount
6682: libmount:      CXT: [0x1f00fb0]: trying to mount by FS 
pattern 'nofoo,bar'
6682: libmount:    UTILS: reading filesystems list 
from: /etc/filesystems
6682: libmount:    UTILS: reading filesystems list 
from: /proc/filesystems
6682: libmount:      CXT: [0x1f00fb0]: /sbin/mount.vfat          ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: /sbin/fs.d/mount.vfat     ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: /sbin/fs/mount.vfat       ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: mount(2) 
[source=/dev/mapper/vg0-root, target=/mnt/tmp, type=vfat,  
mountflags=0xc0ed8000, mountdata=<none>]
6682: libmount:      CXT: [0x1f00fb0]: mount(2) failed [errno=22 Invalid 
argument]
6682: libmount:      CXT: [0x1f00fb0]: /sbin/mount.hfs           ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: /sbin/fs.d/mount.hfs      ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: /sbin/fs/mount.hfs        ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: mount(2) 
[source=/dev/mapper/vg0-root, target=/mnt/tmp, type=hfs,  
mountflags=0xc0ed8000, mountdata=<none>]
6682: libmount:      CXT: [0x1f00fb0]: mount(2) failed [errno=22 Invalid 
argument]
6682: libmount:      CXT: [0x1f00fb0]: /sbin/mount.minix         ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: /sbin/fs.d/mount.minix    ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: /sbin/fs/mount.minix      ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: mount(2) 
[source=/dev/mapper/vg0-root, target=/mnt/tmp, type=minix,  
mountflags=0xc0ed8000, mountdata=<none>]
6682: libmount:      CXT: [0x1f00fb0]: mount(2) failed [errno=22 Invalid 
argument]
6682: libmount:      CXT: [0x1f00fb0]: /sbin/mount.reiserfs      ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: /sbin/fs.d/mount.reiserfs ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: /sbin/fs/mount.reiserfs   ... not 
found
6682: libmount:      CXT: [0x1f00fb0]: mount(2) 
[source=/dev/mapper/vg0-root, target=/mnt/tmp, type=reiserfs,  
mountflags=0xc0ed8000, mountdata=<none>]
6682: libmount:      CXT: [0x1f00fb0]: mount(2) failed [errno=22 Invalid 
argument]
6682: libmount:      CXT: [0x1f00fb0]: /sbin/mount.exfat         ... 
found
6682: libmount:      CXT: [0x1f00fb0]: mount: executing 
helper /sbin/mount.exfat
6682: libmount:      CXT: [0x1f00fb0]: mount: generate helper mount 
options
6697: libmount:      CXT: [0x1f00fb0]: argv[0] = "/sbin/mount.exfat"
6697: libmount:      CXT: [0x1f00fb0]: argv[1] = "/dev/mapper/vg0-root"
6697: libmount:      CXT: [0x1f00fb0]: argv[2] = "/mnt/tmp"
6697: libmount:      CXT: [0x1f00fb0]: argv[3] = "-o"
6697: libmount:      CXT: [0x1f00fb0]: argv[4] = "rw"
FUSE exfat 1.2.6
ERROR: exFAT file system is not found.
6682: libmount:      CXT: [0x1f00fb0]: /sbin/mount.exfat executed 
[status=1, rc=0]
6682: libmount:      CXT: [0x1f00fb0]: don't update: no update prepared
6682: libmount:      CXT: [0x1f00fb0]: excode: rc=1 message=""
6682: libmount:      CXT: [0x1f00fb0]: <---- reset [status=1] ---->
6682: libmount:       FS: [0x1f010b0]: free [refcount=0]
6682: libmount:    CACHE: [0x1f01230]: free [refcount=0]
6682: libmount:   UPDATE: [0x1f01ec0]: free
6682: libmount:      CXT: [0x1f00fb0]: <---- free
