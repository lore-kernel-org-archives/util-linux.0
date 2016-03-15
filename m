Return-Path: util-linux-owner@vger.kernel.org
Received: from ns.horizon.com ([71.41.210.147]:53772 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932212AbcCOSHf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Mar 2016 14:07:35 -0400
Date: 15 Mar 2016 14:07:32 -0400
Message-ID: <20160315180732.19031.qmail@ns.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: kzak@redhat.com
Subject: Re: e2fsck: /dev/hda2 is mounted.
Cc: linux@horizon.com, sweet_f_a@gmx.de, util-linux@vger.kernel.org
In-Reply-To: <20160315131034.gju5rtzm2uacjs7a@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> The problem should be fixed, git pull, make and re-test, please.

After a bit of screwing around with Debian dependencies (the fix ends up
in the libmount package, not the util-linux package, and util-linux only
depends on libmount >= 2.25), I can confirm that it works.

Thank you very much!

LIBMOUNT_DEBUG=all LIBBLKID_DEBUG=all fsck -C -M -A -V

3411: libmount:     INIT: library debug mask: 0xffff
3411: libmount:     INIT: library version: 2.28.
3411: libmount:     INIT:     feature: selinux
3411: libmount:     INIT:     feature: btrfs
3411: libmount:     INIT:     feature: force-mountinfo
3411: libmount:     INIT:     feature: assert
3411: libmount:     INIT:     feature: debug
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
   tab      [0x0020] : fstab, mtab, mounninfo routines
   update   [0x0080] : mtab, utab updates
   utils    [0x0100] : misc library utils
   monitor  [0x0800] : mount tables monitor
   btrfs    [0x1000] : btrfs specific routines
3411: libmount:    CACHE: [0x8d84048]: alloc
fsck from util-linux 2.28-rc1
3411: libmount:      TAB: [0x8d84068]: alloc
3411: libmount:      TAB: [0x8d84068]: /etc/fstab: start parsing [entries=0, filter=not]
3411: libmount:      TAB: [0x8d84068]: add entry: /dev/hda1 none
3411: libmount:      TAB: [0x8d84068]: add entry: /dev/hda2 /
3411: libmount:      TAB: [0x8d84068]: add entry: proc /proc
3411: libmount:      TAB: [0x8d84068]: add entry: tmpfs /tmp
3411: libmount:      TAB: [0x8d84068]: add entry: /dev/fd0 /a
3411: libmount:      TAB: [0x8d84068]: add entry: /dev/hdc /cd
3411: libmount:      TAB: [0x8d84068]: add entry: /dev/hdd /dvd
3411: libmount:      TAB: [0x8d84068]: add entry: /dev/hda3 /home
3411: libmount:       FS: [0x8d849c8]: free [refcount=0]
3411: libmount:      TAB: [0x8d84068]: /etc/fstab: stop parsing (8 entries)
3411: libmount:      TAB: [0x8d84068]: parsing done [filename=/etc/fstab, rc=0]
3411: libmount:    CACHE: [0x8d84048]: canonicalize path /dev/hda2
3411: libmount:    CACHE: [0x8d84048]: add entry [ 1] (path): /dev/hda2: /dev/hda2
3411: libmount:    CACHE: [0x8d84048]: canonicalize path /dev/hda3
3411: libmount:    CACHE: [0x8d84048]: add entry [ 2] (path): /dev/hda3: /dev/hda3
Checking all file systems.
3411: libmount:      TAB: [0x8d84068]: lookup TARGET: '/'
3411: libmount:      TAB: [0x8d84160]: alloc
3411: libmount:      TAB: [0x8d84160]: mtab parse: ignore mtab
3411: libmount:      TAB: [0x8d84160]: mtab parse: #1 read mountinfo
3411: libmount:      TAB: [0x8d84160]: /proc/self/mountinfo: start parsing [entries=0, filter=not]
3411: libmount:      TAB: [0x8d84160]: add entry: /dev/root /
3411: libmount:    CACHE: canonicalize path /proc/self/mountinfo
3411: libmount:      TAB: TID for /proc/self/mountinfo is 3411
3411: libmount:    UTILS: guessing system root [devno 3:2]
3411: libmount:    UTILS:   devno converted to /dev/hda2
3411: libmount:      TAB: [0x8d84160]: canonical root FS: /dev/hda2
3411: libmount:      TAB: [0x8d84160]: add entry: sysfs /sys
3411: libmount:      TAB: [0x8d84160]: add entry: tmpfs /run
3411: libmount:      TAB: [0x8d84160]: add entry: tmpfs /run/lock
3411: libmount:      TAB: [0x8d84160]: add entry: proc /proc
3411: libmount:      TAB: [0x8d84160]: add entry: devtmpfs /dev
3411: libmount:      TAB: [0x8d84160]: add entry: tmpfs /run/shm
3411: libmount:      TAB: [0x8d84160]: add entry: devpts /dev/pts
3411: libmount:      TAB: [0x8d84160]: add entry: tmpfs /tmp
3411: libmount:      TAB: [0x8d84160]: add entry: /dev/hda3 /home
3411: libmount:       FS: [0x8d87dc8]: free [refcount=0]
3411: libmount:      TAB: [0x8d84160]: /proc/self/mountinfo: stop parsing (10 entries)
3411: libmount:      TAB: [0x8d84160]: parsing done [filename=/proc/self/mountinfo, rc=0]
3411: libmount:      TAB: [0x8d84160]: mtab parse: #2 read utab
3411: libmount:      TAB: [0x8d84160]: lookup SOURCE: '/dev/hda2'
3411: libmount:      TAB: [0x8d84160]: lookup SRCPATH: '/dev/hda2'
/dev/hda2 is mounted
3411: libmount:      TAB: [0x8d84160]: lookup SOURCE: '/dev/hda3'
3411: libmount:      TAB: [0x8d84160]: lookup SRCPATH: '/dev/hda3'
/dev/hda3 is mounted
