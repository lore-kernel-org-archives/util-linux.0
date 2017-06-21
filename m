Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f169.google.com ([209.85.216.169]:32928 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbdFUMQA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 21 Jun 2017 08:16:00 -0400
Received: by mail-qt0-f169.google.com with SMTP id u12so155441649qth.0
        for <util-linux@vger.kernel.org>; Wed, 21 Jun 2017 05:15:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 21 Jun 2017 13:15:58 +0100
Message-ID: <CAG27Bk2qLRTEQStSvo7wWeychM+MQofvDGhT_ZOx=4yD7C2v2w@mail.gmail.com>
Subject: mount(8) does not work when using a specific target dir
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

We (Cloudflare) got a strange issue with mount(8) from debian jessie
package v2.25.2. Kernel version is 4.4.46 (self compiled, works on
other servers).

An md device, that is constructed of 12 luks encrypted disks, will not
mount to a path /disk/data but it happily mounts to any other path.
This is rather unfortunate because we expect to see our device in that
path. The same happens with a dummy file-based filesystem[1], so this
is unlikely to be related to the device. Here is a debug sample.

root:/disk# export LIBMOUNT_DEBUG=0xffff
root:/disk# mount /dev/md127 /disk/data
10191: libmount:     INIT: debug mask: 0xffff
10191: libmount:     INIT: library version: 2.25.0
10191: libmount:     INIT:     feature: selinux
10191: libmount:     INIT:     feature: assert
10191: libmount:     INIT:     feature: debug
10191: libmount:      CXT: [0x1a5d080]: ----> allocate
10191: libmount:      CXT: [0x1a5d080]: mount: preparing
10191: libmount:      CXT: [0x1a5d080]: use default optsmode
10191: libmount:      CXT: [0x1a5d080]: OPTSMODE: ignore=0, append=0,
prepend=1, replace=0, force=0, fstab=1, mtab=1
10191: libmount:      CXT: [0x1a5d080]: fstab not required -- skip
10191: libmount:      CXT: [0x1a5d080]: merging mount flags
10191: libmount:      CXT: [0x1a5d080]: final flags: VFS=00000000 user=00000000
10191: libmount:      CXT: [0x1a5d080]: mount: evaluating permissions
10191: libmount:      CXT: [0x1a5d080]: mount: fixing optstr
10191: libmount:      CXT: [0x1a5d080]: mount: fixing vfs optstr
10191: libmount:      CXT: applying 0x00000000 flags to '(null)'
10191: libmount:      CXT: new optstr 'rw'
10191: libmount:      CXT: [0x1a5d080]: mount: fixing user optstr
10191: libmount:      CXT: applying 0x00000000 flags to '(null)'
10191: libmount:      CXT: new optstr '(null)'
10191: libmount:      CXT: [0x1a5d080]: fixed options [rc=0]: vfs:
'rw' fs: '(null)' user: '(null)', optstr: 'rw'
10191: libmount:      CXT: [0x1a5d080]: preparing source path
10191: libmount:      CXT: [0x1a5d080]: srcpath '/dev/md127'
10191: libmount:    CACHE: [0x1a5d2c0]: alloc
10191: libmount:    CACHE: [0x1a5d2c0]: canonicalize path /dev/md127
10191: libmount:    CACHE: [0x1a5d2c0]: add entry [ 1] (path):
/dev/md127: /dev/md127
10191: libmount:      CXT: [0x1a5d080]: final srcpath '/dev/md127'
10191: libmount:      CXT: [0x1a5d080]: preparing target path
10191: libmount:    CACHE: [0x1a5d2c0]: canonicalize path /disk/data
10191: libmount:    CACHE: [0x1a5d2c0]: add entry [ 2] (path):
/disk/data: /disk/data
10191: libmount:      CXT: [0x1a5d080]: final target '/disk/data'
10191: libmount:    CACHE: [0x1a5d2c0]: get /dev/md127 FS type
10191: libmount:    CACHE: [0x1a5d2c0]: tags for /dev/md127 requested
10191: libmount:    CACHE: [0x1a5d2c0]: reading tags for: /dev/md127
10191: libmount:    CACHE: [0x1a5d2c0]: add entry [ 3] (tag): /dev/md127: UUID
10191: libmount:    CACHE: [0x1a5d2c0]: add entry [ 4] (tag): /dev/md127: TYPE
10191: libmount:    CACHE: [0x1a5d2c0]:         read 2 tags
10191: libmount:      CXT: [0x1a5d080]: FS type: ext4 [rc=0]
10191: libmount:      CXT: [0x1a5d080]: /sbin/mount.ext4          ... not found
10191: libmount:      CXT: [0x1a5d080]: /sbin/fs.d/mount.ext4     ... not found
10191: libmount:      CXT: [0x1a5d080]: /sbin/fs/mount.ext4       ... not found
10191: libmount:      CXT: [0x1a5d080]: prepare update
10191: libmount:      CXT: [0x1a5d080]: checking for writable tab files
10191: libmount:    UTILS: mtab: /etc/mtab
10191: libmount:    UTILS: /etc/mtab: irregular/non-writable
10191: libmount:    UTILS: utab: /run/mount/utab
10191: libmount:   UPDATE: [0x1a62270]: allocate
10191: libmount:   UPDATE: [0x1a62270]: resetting FS [fs=0x0x1a5d180,
target=(null), flags=0x00000000]
10191: libmount:   UPDATE: [0x1a62270]: FS template:
10191: libmount:   UPDATE: ------ fs: 0x1a5d180
source: /dev/md127
target: /disk/data
fstype: ext4
optstr: rw
VFS-optstr: rw
10191: libmount:   UPDATE: prepare utab entry
10191: libmount:   UPDATE: utab entry unnecessary (no options)
10191: libmount:      CXT: [0x1a5d080]: mount: do mount
10191: libmount:      CXT: [0x1a5d080]: mount(2) [source=/dev/md127,
target=/disk/data, type=ext4,  mountflags=0xc0ed0000,
mountdata=<none>]
[ 9023.111850] EXT4-fs (md127): mounted filesystem with ordered data
mode. Opts: (null)
10191: libmount:      CXT: [0x1a5d080]: mount(2) success
10191: libmount:      CXT: [0x1a5d080]: don't update: no update prepared
10191: libmount:      CXT: [0x1a5d080]: <---- reset [status=1] ---->
10191: libmount:       FS: [0x1a5d180]: free [refcount=0]
10191: libmount:    CACHE: [0x1a5d2c0]: free [refcount=0]
10191: libmount:   UPDATE: [0x1a62270]: free
10191: libmount:      CXT: [0x1a5d080]: <---- free

Any ideas what could cause that? And just to repeat in sake of being
clear, mounting to other destination directory works fine - even debug
messages are practically identical.

[1] dd if=/dev/zero bs=10M count=1 of=/dummy; mkfs.ext4 /dummy; mount /disk/data

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
