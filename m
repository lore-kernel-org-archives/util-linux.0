Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55793 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754210Ab2JBKSN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Oct 2012 06:18:13 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q92AICFS029052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 2 Oct 2012 06:18:12 -0400
Received: from x2 (ovpn-113-69.phx2.redhat.com [10.3.113.69])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q92AIBUH005103
	for <util-linux@vger.kernel.org>; Tue, 2 Oct 2012 06:18:12 -0400
Date: Tue, 2 Oct 2012 12:18:10 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: v2.22 stable branche
Message-ID: <20121002101810.GJ7730@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 I have created stable/v2.22 (pull from kernel.org or gitgub) for the
 next stable release v2.22.1. See the log below -- any objections or
 suggestions?

    Karel


Bernhard Voelker (1):
      ipcrm: avoid 'uninitialized' warning

Björn Jacke (1):
      mount: fix man path typo in quota mount option names

Bjørn Mork (1):
      dmesg: fix console-level off-by-one

Dave Reisner (1):
      build-sys: install su.1 if building su

Davidlohr Bueso (2):
      blkid: document LIBBLKID_DEBUG users
      libmount: document LIBMOUNT_DEBUG users

Giacomo (1):
      rtcwake: doesn't reset wakealarm

Gilles Espinasse (1):
      textual: typo fixes

Karel Zak (25):
      libblkid: improve DBG() macro
      libblkid: check fchmod() return value [coverity scan]
      namei: remove dead code [coverity scan]
      tunelp: add missing break [coverity scan]
      mark expected fallthrough for static analysers
      lib/sysfs: more robust sysfs_opendir() [coverity scan]
      switch_root: check open() return value [coverity scan]
      lib/pager: robust work with file descriptors [coverity scan]
      whereis: improve readability for analysers
      eject: robust strings usage [coverity scan]
      build-sys: add --disable-wdctl
      wdctl: add fallbacks for old kernel headers
      libmount: improve mnt_table_get_root_fs() docs
      libblkid: fix copyright noticed to be consistent (so all are LGPL)
      libmount: segfaults if neither /etc/filesystems nor/proc/filesystems exists
      libmount: don't remove user= when executed by root
      build-sys: fix --localstatedir heuristics
      build-sys: simplify usrlib_execdir initialization
      libmount: detach loopdev on umount if loop option in mtab
      libmount: append loop option when automatically create loopdev
      hwclock: wait time in hwclock is not long enough for some ARM devices
      libmount: user-mounted loopback fs cannot be unmounted by user
      libmount: optimize mtab and utab parsing in umount
      libmount: don't setup new loopdev on remount with regular mtab
      su: don't modify PATH if -l not specified

Mike Frysinger (1):
      mount: fix a few typos

Milan Broz (1):
      mkswap: wipe old signature if there is no part table by default

Peter Rajnoha (3):
      lib/sysfs: fix sysfs_devname_to_devno for dm partitions
      lsblk: fix processing of dm partition mappings
      lsblk: fix reporting of 'part' type

Petr Uzel (1):
      setterm: make error message more informative

Thierry Reding (1):
      sfdisk: Fix format specifiers for size_t

Tom Gundersen (1):
      hwclock: don't warp the systemtime if the RTC is in UTC

Ville Skyttä (2):
      docs: umount.8 syntax fix.
      docs: AUTHORS, NEWS: UTF-8 fixes.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
