Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:39796 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBE13 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 2 May 2018 00:27:29 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w424RQph010322
        for <util-linux@vger.kernel.org>; Tue, 1 May 2018 21:27:29 -0700
Message-ID: <5AE93E2E.9040506@tlinx.org>
Date: Tue, 01 May 2018 21:27:26 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: FYI...build "ok", thought some warnings, annoyances in 2.32...
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Everything seemed to build, though with warnings and some
annoyances.

It _seems_ most of the warnings are of low importance.

At the annoyance level: of the 8 utils I tried to build statically,
0 worked: "complete static linking is impossible in this configuration".
I wonder if this is a 'SUSE-ism'?

(The problem of static building isn't unique to utils-linux, FWIW...)

Thanks!
-linda

output during make of warnings follows:


libblkid/src/superblocks/zfs.c: In function ‘probe_zfs’:
libblkid/src/superblocks/zfs.c:254:14: warning: ‘offset’ may be used 
uninitialized in this function [-Wmaybe-uninitialized]
--
libmount/src/monitor.c: In function ‘userspace_monitor_close_fd’:
libmount/src/monitor.c:202:62: warning: unused parameter ‘mn’ 
[-Wunused-parameter]
--
libmount/src/monitor.c: In function ‘kernel_monitor_close_fd’:
libmount/src/monitor.c:433:59: warning: unused parameter ‘mn’ 
[-Wunused-parameter]
--
libfdisk/src/sun.c: In function ‘fdisk_new_sun_label’:
libfdisk/src/sun.c:1152:63: warning: unused parameter ‘cxt’ 
[-Wunused-parameter]
--
libfdisk/src/sgi.c: In function ‘fdisk_new_sgi_label’:
libfdisk/src/sgi.c:1181:63: warning: unused parameter ‘cxt’ 
[-Wunused-parameter]
--
libfdisk/src/dos.c: In function ‘fdisk_new_dos_label’:
libfdisk/src/dos.c:2467:63: warning: unused parameter ‘cxt’ 
[-Wunused-parameter]
--
libfdisk/src/bsd.c: In function ‘fdisk_new_bsd_label’:
libfdisk/src/bsd.c:1031:63: warning: unused parameter ‘cxt’ 
[-Wunused-parameter]
--
libfdisk/src/gpt.c: In function ‘fdisk_new_gpt_label’:
libfdisk/src/gpt.c:3143:63: warning: unused parameter ‘cxt’ 
[-Wunused-parameter]
--
  CCLD     losetup.static
libtool: warning: complete static linking is impossible in this 
configuration
--
  CCLD     mount.static
libtool: warning: complete static linking is impossible in this 
configuration
--
  CCLD     umount.static
libtool: warning: complete static linking is impossible in this 
configuration
--
  CCLD     blkid.static
libtool: warning: complete static linking is impossible in this 
configuration
--
disk-utils/fdisk.c: In function ‘ask_number’:
disk-utils/fdisk.c:294:11: warning: ‘num’ may be used uninitialized in 
this function [-Wmaybe-uninitialized]
--
disk-utils/fdisk.c: In function ‘ask_number’:
disk-utils/fdisk.c:294:11: warning: ‘num’ may be used uninitialized in 
this function [-Wmaybe-uninitialized]
--
  CCLD     fdisk.static
libtool: warning: complete static linking is impossible in this 
configuration
--
  CCLD     sfdisk.static
libtool: warning: complete static linking is impossible in this 
configuration
--
  CCLD     unshare.static
libtool: warning: complete static linking is impossible in this 
configuration
--
  CCLD     nsenter.static
libtool: warning: complete static linking is impossible in this 
configuration



