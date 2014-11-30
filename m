Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33774 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbaK3N5s (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 08:57:48 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so11968963wgh.6
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 05:57:46 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/10] pull: AddressSanitizer round II
Date: Sun, 30 Nov 2014 13:57:32 +0000
Message-Id: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here comes the second set of changes to enable AddressSanitizer one day
in future.  These changed does not include update to travis-functions, as
demonstrated below, due reason explained later.  The environment changes
in the diff are useful for other who want to try ASAN compilations.

diff --git a/.travis-functions.sh b/.travis-functions.sh
index ed491f4..875b8ad 100755
--- a/.travis-functions.sh
+++ b/.travis-functions.sh
@@ -52,6 +52,12 @@ function check_nonroot
 
 function check_root
 {
+	case $CC in
+	*clang)
+		export CFLAGS="$CFLAGS -O1 -g -fsanitize=address -fno-omit-frame-pointer -fsanitize=undefined"
+		export ASAN_SYMBOLIZER_PATH=`which llvm-symbolizer`
+		;;
+	esac
 	configure_travis \
 		--with-python \
 		--enable-all-programs \

The reason why the above is not added to this change set is that travis
has clang-3.4 and reports the following false positive error.

-- snip
==3344==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7fffe6e45cf0 at pc 0x4501f9 bp 0x7fffe6e45b50 sp 0x7fffe6e45b28
WRITE of size 112 at 0x7fffe6e45cf0 thread T0
    #0 0x4501f8 in shmctl /home/users/aadgrand/LLVM/releases/ubuntu/final/llvm.src/projects/compiler-rt/lib/sanitizer_common/sanitizer_common_interceptors.inc:2502
    #1 0x488642 in do_shm /home/travis/build/kerolasa/lelux-utiliteetit/sys-utils/ipcs.c:214
    #2 0x4844a8 in main /home/travis/build/kerolasa/lelux-utiliteetit/sys-utils/ipcs.c:175
    #3 0x2b186c94976c (/lib/x86_64-linux-gnu/libc.so.6+0x2176c)
    #4 0x48408c in _start (/home/travis/build/kerolasa/lelux-utiliteetit/ipcs+0x48408c)

Address 0x7fffe6e45cf0 is located in stack of thread T0 at offset 272 in frame
    #0 0x48831f in do_shm /home/travis/build/kerolasa/lelux-utiliteetit/sys-utils/ipcs.c:187

  This frame has 3 object(s):
    [32, 40) 'shmds'
    [96, 168) 'lim'
    [224, 272) 'shm_info' <== Memory access at offset 272 overflows this variable
-- snip

The error does not happen with clang-3.5.0, and I have hunch the issue
fix below has something to do with this.

https://code.google.com/p/address-sanitizer/issues/detail?id=259

In my mind it would be best to wait travis clang update before taking the
AddressSanitizer in automatic use.  Else some sort of ipcs temporary
workaround is needed.  But adding a workaround to satisfy static analyzer
feels wrong, so how about fixing the issue by waiting an update that
inevitably will happen sooner or later.

Meanwhile there is still a code issues:

        fdisk: MBR - sort                     ...include/pt-mbr.h:24:51: runtime error: left shift of 233 by 24 places cannot be represented in type 'int'
include/pt-mbr.h:24:51: runtime error: left shift of 233 by 24 places cannot be represented in type 'int'
include/pt-mbr.h:24:51: runtime error: left shift of 233 by 24 places cannot be represented in type 'int'

I don't know how to fix that without '(possibly|likely)' breaking something.

In case someone is curious to see how travis build log looks here is a
sample.  Downloading the file and reading with 'less -r' (imho) improves
reading experience of that file.

https://s3.amazonaws.com/archive.travis-ci.org/jobs/42539750/log.txt


Sami Kerola (10):
  lib/mbalign: fix unsigned integer overflow [AddressSanitizer]
  cal: fix signed integer overflow [AddressSanitizer]
  more: fix unsigned integer overflow [AddressSanitizer]
  lib: fix crc32 and crc64 interger overflows [AddressSanitizer]
  fdisk: (sgi) fix unsigned integer overflow [AddressSanitizer]
  strutils: fix unsigned integer overflows [AddressSanitizer]
  mkfs.cramfs: fix unsigned integer overflow [AddressSanitizer]
  include/c: define UL_ASAN_BLACKLIST address_sanitizer function
    attribute
  lscpu: blacklist vmware_bdoor() AddressSanitizer check
  ipcs: fix two data type errors [AddressSanitizer]

 disk-utils/mkfs.cramfs.c    |   5 +-
 include/c.h                 |  17 +++
 include/pt-sgi.h            |   4 +-
 include/strutils.h          |   9 +-
 lib/crc32.c                 |   4 +-
 lib/crc64.c                 |   3 +-
 lib/mbsalign.c              |   2 +-
 misc-utils/cal.c            |   6 +-
 sys-utils/ipcutils.c        |   4 +-
 sys-utils/lscpu.c           |   2 +-
 tests/expected/cal/bigyear  | 312 +++++++++++++++++++++---------------------
 tests/expected/cal/bigyearw | 324 ++++++++++++++++++++++----------------------
 text-utils/more.c           |   6 +-
 13 files changed, 364 insertions(+), 334 deletions(-)

-- 
2.1.3

