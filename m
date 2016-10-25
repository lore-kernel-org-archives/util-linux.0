Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:59835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbcJYWAR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 25 Oct 2016 18:00:17 -0400
Received: from tenfore.site ([77.12.159.228]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LhwAY-1cksud3qOg-00nDRo for
 <util-linux@vger.kernel.org>; Wed, 26 Oct 2016 00:00:14 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: libfdisk show stopper on i586?
Date: Wed, 26 Oct 2016 00:00:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201610260000.12844.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

looks like some of the last commits between v2.29-rc2-1-ge5cc93b
and v2.29-rc2-22-g82e8dda introduced issues on some i586 systems.

For example on  Fedora 19 i586:


[  202.120451] systemd-coredump[8629]: Failed to send coredump: No such file or directory
/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/tests/ts/fdisk/gpt: line 37:  8615 Aborted                 (core dumped) $TS_CMD_FDISK -l ${TEST_IMAGE_NAME} >> $TS_OUTPUT 2>&1

        fdisk: GPT                                           ... FAILED (fdisk/gpt)

## test diff
--- /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/tests/expected/fdisk/gpt   2016-03-29 19:30:31.588100795 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/tests/output/fdisk/gpt     2016-10-25 20:44:55.972000000 +0000
@@ -2,137 +2,462 @@
 Create new GPT partition table

 ---layout----------
+*** Error in `/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/lt-fdisk': munmap_chunk(): invalid pointer: 0xf7733b73 ***
+======= Backtrace: =========
+/lib/libc.so.6(+0x74804)[0xf74a8804]
+/lib/libc.so.6(+0x17c7f)[0xf744bc7f]
+/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libfdisk.so.1(fdisk_reset_labelitem+0x83)[0xf76ec2d3]
+/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libfdisk.so.1(fdisk_get_disklabel_item+0x40)[0xf76f1700]
+/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libfdisk.so.1(fdisk_get_disklabel_id+0x5c)[0xf76f192c]
+/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/lt-fdisk[0x80525a0]
+/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/lt-fdisk[0x80535f8]
+/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/lt-fdisk[0x804d330]
+/lib/libc.so.6(__libc_start_main+0xf3)[0xf744d963]
+/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/lt-fdisk[0x804d615]
+======= Memory map: ========
+08048000-08062000 r-xp 00000000 08:00 754020                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/lt-fdisk
+08062000-08063000 r--p 00019000 08:00 754020                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/lt-fdisk
+08063000-08064000 rw-p 0001a000 08:00 754020                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/lt-fdisk
+08064000-08065000 rw-p 00000000 00:00 0
+08d34000-08d55000 rw-p 00000000 00:00 0                                  [heap]
+f7414000-f742f000 r-xp 00000000 08:00 384797                             /usr/lib/libgcc_s-4.8.1-20130603.so.1
+f742f000-f7430000 r--p 0001a000 08:00 384797                             /usr/lib/libgcc_s-4.8.1-20130603.so.1
+f7430000-f7431000 rw-p 0001b000 08:00 384797                             /usr/lib/libgcc_s-4.8.1-20130603.so.1
+f7434000-f75ec000 r-xp 00000000 08:00 384806                             /usr/lib/libc-2.17.so
+f75ec000-f75ee000 r--p 001b7000 08:00 384806                             /usr/lib/libc-2.17.so
+f75ee000-f75ef000 rw-p 001b9000 08:00 384806                             /usr/lib/libc-2.17.so
+f75ef000-f75f2000 rw-p 00000000 00:00 0
+f75f4000-f762b000 r-xp 00000000 08:00 385173                             /usr/lib/libreadline.so.6.2
+f762b000-f762c000 r--p 00037000 08:00 385173                             /usr/lib/libreadline.so.6.2
+f762c000-f762f000 rw-p 00038000 08:00 385173                             /usr/lib/libreadline.so.6.2
+f762f000-f7631000 rw-p 00000000 00:00 0
+f7634000-f7653000 r-xp 00000000 08:00 384963                             /usr/lib/libtinfo.so.5.9
+f7653000-f7655000 r--p 0001e000 08:00 384963                             /usr/lib/libtinfo.so.5.9
+f7655000-f7656000 rw-p 00020000 08:00 384963                             /usr/lib/libtinfo.so.5.9
+f7664000-f768b000 r-xp 00000000 08:00 752363                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libsmartcols.so.1.1.0
+f768b000-f768c000 r--p 00026000 08:00 752363                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libsmartcols.so.1.1.0
+f768c000-f768d000 rw-p 00027000 08:00 752363                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libsmartcols.so.1.1.0
+f768d000-f768e000 rw-p 00000000 00:00 0
+f7693000-f7694000 rw-p 00000000 00:00 0
+f7694000-f7698000 r-xp 00000000 08:00 752357                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libuuid.so.1.3.0
+f7698000-f7699000 r--p 00003000 08:00 752357                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libuuid.so.1.3.0
+f7699000-f769a000 rw-p 00004000 08:00 752357                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libuuid.so.1.3.0
+f769a000-f769c000 rw-p 00000000 00:00 0
+f769c000-f76df000 r-xp 00000000 08:00 752378                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libblkid.so.1.1.0
+f76df000-f76e0000 ---p 00043000 08:00 752378                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libblkid.so.1.1.0
+f76e0000-f76e2000 r--p 00043000 08:00 752378                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libblkid.so.1.1.0
+f76e2000-f76e3000 rw-p 00045000 08:00 752378                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libblkid.so.1.1.0
+f76e3000-f76e4000 rw-p 00000000 00:00 0
+f76e4000-f7742000 r-xp 00000000 08:00 752383                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libfdisk.so.1.1.0
+f7742000-f7743000 r--p 0005d000 08:00 752383                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libfdisk.so.1.1.0
+f7743000-f7745000 rw-p 0005e000 08:00 752383                             /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libfdisk.so.1.1.0
+f7745000-f7747000 rw-p 00000000 00:00 0
+f7747000-f774a000 r--p 00000000 00:00 0                                  [vvar]
+f774a000-f774c000 r-xp 00000000 00:00 0                                  [vdso]
+f774c000-f776b000 r-xp 00000000 08:00 384799                             /usr/lib/ld-2.17.so
+f776b000-f776c000 r--p 0001e000 08:00 384799                             /usr/lib/ld-2.17.so
+f776c000-f776d000 rw-p 0001f000 08:00 384799                             /usr/lib/ld-2.17.so
+f776d000-f776f000 rw-p 00000000 00:00 0
+ffb6a000-ffb8b000 rw-p 00000000 00:00 0                                  [stack]


cu,
Rudi
