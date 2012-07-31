Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:65472 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab2GaGNt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 31 Jul 2012 02:13:49 -0400
Message-ID: <5017779B.3060700@bernhard-voelker.de>
Date: Tue, 31 Jul 2012 08:13:47 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: tests: libmount/context: 3 of 7 tests fail
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

3 out of the 7 "context" tests fail:

== 1 ==
libmount/context-mount-by-label:

  --- /media/sdb5/berny/git/util-linux/tests/expected/libmount/context-mount-by-label     2011-07-19 12:33:59.000000000
+0200
  +++ /media/sdb5/berny/git/util-linux/tests/output/libmount/context-mount-by-label       2012-07-31 07:48:17.278156133
+0200
  @@ -1 +1,2 @@
  -successfully mounted
  +failed to mount: No such file or directory
  +FAILED [rc=-5002](by label) cannot find /dev/sdh1 in /media/sdb5/berny/git/util-linux/tests/output/libmount/context.mtab

An additional strace finds the reason:

  stat("/dev/disk/by-label/libmount-test", 0x7fff11d9a1f0) = -1 ENOENT (No such file or directory)


== 2 ==
libmount/context-umount-by-mountpoint:

  --- /media/sdb5/berny/git/util-linux/tests/expected/libmount/context-umount-by-mountpoint       2011-07-19
12:33:59.000000000 +0200
  +++ /media/sdb5/berny/git/util-linux/tests/output/libmount/context-umount-by-mountpoint 2012-07-31 08:00:51.697334780
+0200
  @@ -1 +1,2 @@
  -successfully umounted
  +failed to umount
  +FAILED [rc=22]
  \ No newline at end of file

and the strace output:

  umount("/media/sdb5/berny/git/util-linux"..., 0) = -1 EINVAL (Invalid argument)

I think this is because the previous test context-mount-by-label failed.


== 3 ==
libmount/context-mount-by-uuid:

Similar to #1:

  --- /media/sdb5/berny/git/util-linux/tests/expected/libmount/context-mount-by-uuid      2011-07-19 12:33:59.000000000
+0200
  +++ /media/sdb5/berny/git/util-linux/tests/output/libmount/context-mount-by-uuid        2012-07-31 07:51:50.671831873
+0200
  @@ -1,2 +1,4 @@
  -successfully mounted
  -successfully umounted
  +failed to mount: No such file or directory
  +FAILED [rc=-5002](by uuid) cannot find /dev/sdh1 in /media/sdb5/berny/git/util-linux/tests/output/libmount/context.mtab
  +failed to umount
  +FAILED [rc=22]
  \ No newline at end of file

and the strace output:

  stat("/dev/disk/by-uuid/ebda8159-3411-4d0b-a5c4-369cefc900f5", 0x7fffad358cd0) = -1 ENOENT (No such file or directory)

Is this a test framework failure, a real error or is there
something strange on my PC (OpenSuSE-12.1 64-bit)?

Have a nice day,
Berny

