Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:53800 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab2LIRwd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Dec 2012 12:52:33 -0500
Message-ID: <50C4CFDD.1070405@bernhard-voelker.de>
Date: Sun, 09 Dec 2012 18:52:29 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: blkid: exit code as non-root user, and segfault
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

blkid returns 0 without output when running as non-root user
and when the cache /dev/.blkid.tab is not yet there:

  ./blkid /dev/sdb3 ; echo $?
  0

That's the strace:

  open("/dev/.blkid.tab", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
  access("/dev/sdb3", F_OK)               = 0
  stat("/dev/sdb3", {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 19), ...}) = 0
  open("/dev/sdb3", O_RDONLY|O_CLOEXEC)   = -1 EACCES (Permission denied)
  stat("/dev/.blkid.tab", 0x7fff2b7cc990) = -1 ENOENT (No such file or directory)
  open("/dev/.blkid.tab", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
  close(1)                                = 0
  close(2)                                = 0
  exit_group(0)                           = ?

I'd have expected either an error message along with exit code 1,
or success with some useful output.

After the cache exists, it's fine:

  ./blkid  /dev/sdb3 ; echo $?
  /dev/sdb3: LABEL="home" UUID="41ec7daa-46c3-4f19-aea0-e2c1679bb557" TYPE="ext3"
  0


And another issue: blkid segfaults with this - okay, bad use of options:

  ./blkid -n /dev/sdb3
  Segmentation fault

Backtrace:
  (gdb) bt
  #0  0x00007ff64fe72121 in __strlen_sse2 () from /lib64/libc.so.6
  #1  0x00007ff65039029b in blkid_dev_set_search (iter=0x6090c0, search_type=0x0, search_value=0x0) at
libblkid/src/dev.c:151
  #2  0x00000000004036e8 in main (argc=<optimized out>, argv=<optimized out>) at misc-utils/blkid.c:925

Using latest git; it doesn't dump core with 2.20.1.

Have a nice day,
Berny
