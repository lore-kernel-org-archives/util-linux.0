Return-Path: util-linux-owner@vger.kernel.org
Received: from ns.horizon.com ([71.41.210.147]:43912 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752191AbcCMKVh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 06:21:37 -0400
Date: 13 Mar 2016 06:14:14 -0400
Message-ID: <20160313101414.19038.qmail@ns.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: kzak@redhat.com, util-linux@vger.kernel.org
Subject: e2fsck: /dev/hda2 is mounted.
Cc: linux@horizon.com
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

After a recent upgrade of a Debian system, I discovered that
systems weren't rebooting; they would always halt in the automatic
fsck of other file systems.

Upon investigation, it turned out that fsck didn't understand the
kernel "root=302" parameter and was trying to run e2fsck on the root
file system.  This produced an error, causing the boot process
to drop into a recovery shell.

System is i386, current Debian sid (unstable).  But I compiled
util-linux from the git sources to eliminate Debianisms from
the problem.

Running the v2.28-rc1 release (8c97556ecfc0af358d35dc7a842aaadde5eeafd3)
I got some compile warnings (appended for reference), but a
working execurable which could be run as follows:

LIBMOUNT_DEBUG=all LIBBLKID_DEBUG=all ./fsck -C -M -A -V

32305: libmount:     INIT: library debug mask: 0xffff
32305: libmount:     INIT: library version: 2.28.
32305: libmount:     INIT:     feature: btrfs
32305: libmount:     INIT:     feature: assert
32305: libmount:     INIT:     feature: debug
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
32305: libmount:    CACHE: [0x983a048]: alloc
lt-fsck from util-linux 2.28-rc1
32305: libmount:      TAB: [0x983a068]: alloc
32305: libmount:      TAB: [0x983a068]: /etc/fstab: start parsing [entries=0, filter=not]
32305: libmount:      TAB: [0x983a068]: add entry: /dev/hda1 none
32305: libmount:      TAB: [0x983a068]: add entry: /dev/hda2 /
32305: libmount:      TAB: [0x983a068]: add entry: proc /proc
32305: libmount:      TAB: [0x983a068]: add entry: tmpfs /tmp
32305: libmount:      TAB: [0x983a068]: add entry: /dev/fd0 /a
32305: libmount:      TAB: [0x983a068]: add entry: /dev/hdc /cd
32305: libmount:      TAB: [0x983a068]: add entry: /dev/hdd /dvd
32305: libmount:      TAB: [0x983a068]: add entry: /dev/hda3 /home
32305: libmount:       FS: [0x983a9c8]: free [refcount=0]
32305: libmount:      TAB: [0x983a068]: /etc/fstab: stop parsing (8 entries)
32305: libmount:      TAB: [0x983a068]: parsing done [filename=/etc/fstab, rc=0]
32305: libmount:    CACHE: [0x983a048]: canonicalize path /dev/hda2
32305: libmount:    CACHE: [0x983a048]: add entry [ 1] (path): /dev/hda2: /dev/hda2
32305: libmount:    CACHE: [0x983a048]: canonicalize path /dev/hda3
32305: libmount:    CACHE: [0x983a048]: add entry [ 2] (path): /dev/hda3: /dev/hda3
Checking all file systems.
32305: libmount:      TAB: [0x983a068]: lookup TARGET: '/'
32305: libmount:      TAB: [0x983a160]: alloc
32305: libmount:    UTILS: mtab: /etc/mtab
32305: libmount:    UTILS: /etc/mtab: irregular/non-writable
32305: libmount:      TAB: [0x983a160]: mtab parse: #1 read mountinfo
32305: libmount:      TAB: [0x983a160]: /proc/self/mountinfo: start parsing [entries=0, filter=not]
32305: libmount:      TAB: [0x983a160]: add entry: /dev/root /
32305: libmount:    CACHE: canonicalize path /proc/self/mountinfo
32305: libmount:      TAB: TID for /proc/self/mountinfo is 32305
32305: libmount:      TAB: [0x983a160]: root FS: 302
32305: libmount:    CACHE: [0x983a048]: canonicalize path 302
32305: libmount:    CACHE: [0x983a048]: add entry [ 3] (path): 302: 302
32305: libmount:      TAB: [0x983a160]: canonical root FS: 302
32305: libmount:      TAB: [0x983a160]: add entry: sysfs /sys
32305: libmount:      TAB: [0x983a160]: add entry: tmpfs /run
32305: libmount:      TAB: [0x983a160]: add entry: tmpfs /run/lock
32305: libmount:      TAB: [0x983a160]: add entry: proc /proc
32305: libmount:      TAB: [0x983a160]: add entry: devtmpfs /dev
32305: libmount:      TAB: [0x983a160]: add entry: tmpfs /run/shm
32305: libmount:      TAB: [0x983a160]: add entry: devpts /dev/pts
32305: libmount:      TAB: [0x983a160]: add entry: tmpfs /tmp
32305: libmount:      TAB: [0x983a160]: add entry: /dev/hda3 /home
32305: libmount:       FS: [0x983ddc8]: free [refcount=0]
32305: libmount:      TAB: [0x983a160]: /proc/self/mountinfo: stop parsing (10 entries)
32305: libmount:      TAB: [0x983a160]: parsing done [filename=/proc/self/mountinfo, rc=0]
32305: libmount:      TAB: [0x983a160]: mtab parse: #2 read utab
32305: libmount:      TAB: [0x983a160]: lookup SOURCE: '/dev/hda2'
32305: libmount:      TAB: [0x983a160]: lookup SRCPATH: '/dev/hda2'
32305: libmount:      TAB: [0x983a160]: lookup canonical SRCPATH: '/dev/hda2'
/dev/hda2 is not mounted
[/sbin/fsck.ext4 (1) -- /] fsck.ext4 -C0 /dev/hda2 
32318: libblkid:     INIT: library debug mask: 0xffff
32318: libblkid:     INIT: library version: 2.27.0 [02-Nov-2015]
Available "LIBBLKID_DEBUG=<name>[,...]|<mask>" debug masks:
   all      [0xffff] : info about all subsystems
   cache    [0x0004] : blkid tags cache
   config   [0x0008] : config file utils
   dev      [0x0010] : device utils
   devname  [0x0020] : /proc/partitions evaluation
   devno    [0x0040] : convertions to device name
   evaluate [0x0080] : tags resolving
   help     [0x0001] : this help
   lowprobe [0x0100] : superblock/raids/partitions probing
   probe    [0x0200] : devices verification
   read     [0x0400] : cache parsing
   save     [0x0800] : cache writing
   tag      [0x1000] : tags utils
32318: libblkid:    CACHE: creating blkid cache (using default cache)
32318: libblkid:   CONFIG: reading config file: /etc/blkid.conf.
32318: libblkid:   CONFIG: /etc/blkid.conf: does not exist, using built-in default
32318: libblkid:      TAG: looking for /dev/hda2 in cache
e2fsck 1.43-WIP (18-May-2015)
/dev/hda2 is mounted.
e2fsck: Cannot continue, aborting.


I'm not quite sure where in the code this is *supposed* to be parsed
so I haven't found the bug yet.  It *used* to work, but I fear it's
been months since my last reboot and I don't have a list of everything
that changed.



Other problems encountered during compilation:

checking linux/gsmmux.h usability... no
checking linux/gsmmux.h presence... yes
configure: WARNING: linux/gsmmux.h: present but cannot be compiled
configure: WARNING: linux/gsmmux.h:     check for missing prerequisite headers?
configure: WARNING: linux/gsmmux.h: see the Autoconf documentation
configure: WARNING: linux/gsmmux.h:     section "Present But Cannot Be Compiled"
configure: WARNING: linux/gsmmux.h: proceeding with the compiler's result
configure: WARNING:     ## ------------------------------ ##
configure: WARNING:     ## Report this to kzak@redhat.com ##
configure: WARNING:     ## ------------------------------ ##
checking for linux/gsmmux.h... no


The details from config.log look more like a problem with the headers
rather than util-linux, but it says report it, so I am:

configure:18012: checking linux/gsmmux.h usability
configure:18012: gcc -c -g -O2  conftest.c >&5
In file included from /usr/include/linux/gsmmux.h:4:0,
                 from conftest.c:79:
/usr/include/linux/if.h:211:19: error: field 'ifru_addr' has incomplete type
   struct sockaddr ifru_addr;
                   ^
/usr/include/linux/if.h:212:19: error: field 'ifru_dstaddr' has incomplete type
   struct sockaddr ifru_dstaddr;
                   ^
/usr/include/linux/if.h:213:19: error: field 'ifru_broadaddr' has incomplete type
   struct sockaddr ifru_broadaddr;
                   ^
/usr/include/linux/if.h:214:19: error: field 'ifru_netmask' has incomplete type
   struct sockaddr ifru_netmask;
                   ^
/usr/include/linux/if.h:215:20: error: field 'ifru_hwaddr' has incomplete type
   struct  sockaddr ifru_hwaddr;
                    ^
configure:18012: $? = 1



There were also two batches of complaints about mismatched types in printf:

  CC       libfdisk/src/libfdisk_la-alignment.lo
In file included from libfdisk/src/fdiskP.h:25:0,
                 from libfdisk/src/alignment.c:7:
libfdisk/src/alignment.c: In function 'fdisk_align_lba':
libfdisk/src/alignment.c:115:29: warning: format '%ju' expects argument of type 'uintmax_t', but argument 6 has type 'long unsigned int' [-Wformat=]
   DBG(CXT, ul_debugobj(cxt, "LBA %ju -aligned-%s-> %ju [grain=%jus]",
                             ^
./include/debug.h:63:4: note: in definition of macro '__UL_DBG'
    x; \
    ^
libfdisk/src/alignment.c:115:3: note: in expansion of macro 'DBG'
   DBG(CXT, ul_debugobj(cxt, "LBA %ju -aligned-%s-> %ju [grain=%jus]",
   ^


  CC       sys-utils/lsns-lsns.o
In file included from sys-utils/lsns.c:45:0:
sys-utils/lsns.c: In function 'add_namespace':
sys-utils/lsns.c:346:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'ino_t {aka long long unsigned int}' [-Wformat=]
  DBG(NS, ul_debugobj(ns, "new %s[%lu]", ns_names[type], ino));
                          ^
./include/debug.h:63:4: note: in definition of macro '__UL_DBG'
    x; \
    ^
sys-utils/lsns.c:346:2: note: in expansion of macro 'DBG'
  DBG(NS, ul_debugobj(ns, "new %s[%lu]", ns_names[type], ino));
  ^
sys-utils/lsns.c: In function 'add_process_to_namespace':
sys-utils/lsns.c:362:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'ino_t {aka long long unsigned int}' [-Wformat=]
  DBG(NS, ul_debugobj(ns, "add process [%p] pid=%d to %s[%lu]", proc, proc->pid,
                          ^
./include/debug.h:63:4: note: in definition of macro '__UL_DBG'
    x; \
    ^
sys-utils/lsns.c:362:2: note: in expansion of macro 'DBG'
  DBG(NS, ul_debugobj(ns, "add process [%p] pid=%d to %s[%lu]", proc, proc->pid,
  ^
sys-utils/lsns.c: In function 'add_scols_line':
sys-utils/lsns.c:440:20: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'ino_t {aka long long unsigned int}' [-Wformat=]
    xasprintf(&str, "%lu", ns->id);
                    ^

