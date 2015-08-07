Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63595 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756282AbbHGHUx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Aug 2015 03:20:53 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 2/2] tests: add fsck.minix checks
Date: Fri, 7 Aug 2015 09:20:45 +0200
Cc: util-linux@vger.kernel.org
References: <1438540140-959-1-git-send-email-kerolasa@iki.fi> <1438540140-959-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1438540140-959-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201508070920.46201.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 02 August 2015, Sami Kerola wrote:
> The debian bug was fixed in commit 730ae9c89971, and the rest are
> about having test coverity for various file name lenghts and minix fs
> versions.
>
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  tests/expected/minix/fsck-images-auto-fix     |  31 ++++++++++++
>  tests/expected/minix/fsck-images-broken-root  |   7 +++
>  tests/expected/minix/fsck-images-bug.773892   |   1 +
>  tests/expected/minix/fsck-images-check-blocks |   9 ++++
>  tests/expected/minix/fsck-images-v1c14        |   9 ++++
>  tests/expected/minix/fsck-images-v1c30        |   9 ++++
>  tests/expected/minix/fsck-images-v2c14        |   9 ++++
>  tests/expected/minix/fsck-images-v2c30        |   9 ++++
>  tests/expected/minix/fsck-images-v3c60        |   9 ++++
>  tests/ts/minix/broken-root                    | Bin 0 -> 5120 bytes
>  tests/ts/minix/debian.bug.773892              | Bin 0 -> 16384 bytes
>  tests/ts/minix/fsck-images                    |  67
> ++++++++++++++++++++++++++ 12 files changed, 160 insertions(+)
>  create mode 100644 tests/expected/minix/fsck-images-auto-fix
>  create mode 100644 tests/expected/minix/fsck-images-broken-root
>  create mode 100644 tests/expected/minix/fsck-images-bug.773892
>  create mode 100644 tests/expected/minix/fsck-images-check-blocks
>  create mode 100644 tests/expected/minix/fsck-images-v1c14
>  create mode 100644 tests/expected/minix/fsck-images-v1c30
>  create mode 100644 tests/expected/minix/fsck-images-v2c14
>  create mode 100644 tests/expected/minix/fsck-images-v2c30
>  create mode 100644 tests/expected/minix/fsck-images-v3c60
>  create mode 100644 tests/ts/minix/broken-root
>  create mode 100644 tests/ts/minix/debian.bug.773892
>  create mode 100755 tests/ts/minix/fsck-images

These tests fail on big endian systems, see below. We could fix most of them by
adding BE md5sum like we did for other tests. Unfortunately I don't have time to
do that before 2.27.

BTW I think a better solution would be to compare hexdumps instead of md5sums
anyway. Maybe it's possible to write a shell function which produces
"endianess-invariant hexdumps" of minix images?


Test failures:

        minix: mkfs checksums                 ... OK
        minix: fsck images                    ...
                : v1c14                       ... FAILED (minix/fsck-images-v1c14)
                : v1c30                       ... FAILED (minix/fsck-images-v1c30)
                : v2c14                       ... FAILED (minix/fsck-images-v2c14)
                : v2c30                       ... FAILED (minix/fsck-images-v2c30)
                : v3c60                       ... FAILED (minix/fsck-images-v3c60)
                : auto-fix                    ...fsck.minix from util-linux 2.27.rc1-45-41e55
bad magic number in super-block
 FAILED (minix/fsck-images-auto-fix)
                : bug.773892                  ... FAILED (minix/fsck-images-bug.773892)
                : broken-root                 ... FAILED (minix/fsck-images-broken-root)
                : check-blocks                ... FAILED (minix/fsck-images-check-blocks)
           ... FAILED (9 from 9 sub-tests)
        minix: mkfs                           ...
                : v1c14                       ... OK
                : v1c30                       ... OK
                : v2c14                       ... OK
                : v2c30                       ... OK
                : v3c60                       ... OK
           ... OK (all 5 sub-tests PASSED)
[...]
--- /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/expected/minix/fsck-images-auto-fix       2015-08-06 21:28:12.906048709 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/output/minix/fsck-images-auto-fix 2015-08-06 21:45:54.950000003 +0000
@@ -1,31 +1,2 @@
-Filesystem auto-fix is dirty, needs checking.
-Read error: bad block in file '/'
-16 inodes
-16 blocks
-Firstdatazone=5 (5)
-Zonesize=1024
-Maxsize=2147483647
-namelen=60
-
-Read error: bad block in file '/'
-/: bad directory: '.' isn't first
-Read error: bad block in file '/'
-/: bad directory: '..' isn't second
-Inode 1 not used, marked used in the bitmap.
-
-     0 inodes used (0%)
-     6 zones used (37%)
-
-     0 regular files
-     0 directories
-     0 character device files
-     0 block device files
-     1 links
-     0 symbolic links
-------
-     1 files
-----------------------------
-FILE SYSTEM HAS BEEN CHANGED
-----------------------------
 0
-29f0edbcb7e405bbc56e614af3c3cb7c auto-fix.img
+346e041d9a762fc6be2feb97904c1a4a auto-fix.img
--- /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/expected/minix/fsck-images-broken-root    2015-08-06 21:28:12.906048709 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/output/minix/fsck-images-broken-root      2015-08-06 21:45:55.090000003 +0000
@@ -1,7 +1,3 @@
-Read error: bad block in file '/'
-Read error: bad block in file '/'
-/: bad directory: '.' isn't first
-Read error: bad block in file '/'
-/: bad directory: '..' isn't second
-Inode 1 not used, marked used in the bitmap.
-4
+fsck.minix from util-linux 2.27.rc1-45-41e55
+bad magic number in super-block
+8
--- /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/expected/minix/fsck-images-bug.773892     2015-08-06 21:28:12.917048708 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/output/minix/fsck-images-bug.773892       2015-08-06 21:45:55.020000003 +0000
@@ -1 +1,3 @@
-0
+fsck.minix from util-linux 2.27.rc1-45-41e55
+bad magic number in super-block
+8
--- /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/expected/minix/fsck-images-check-blocks   2015-08-06 21:28:12.917048708 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/output/minix/fsck-images-check-blocks     2015-08-06 21:45:55.180000003 +0000
@@ -6,4 +6,4 @@

 mkfs return value: 0
 fsck return value: 0
-9336eb47979f61e934c3aec3434333d7
+ffa06ab882e916a42abea58342256830
--- /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/expected/minix/fsck-images-v1c14  2015-08-06 21:28:12.917048708 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/output/minix/fsck-images-v1c14    2015-08-06 21:45:54.650000003 +0000
@@ -6,4 +6,4 @@

 mkfs return value: 0
 fsck return value: 0
-663e1fb18fc074fc15bdb698b0fd0fda
+c9122b1cbfc311669752aef8fc94cd7b
--- /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/expected/minix/fsck-images-v1c30  2015-08-06 21:28:12.917048708 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/output/minix/fsck-images-v1c30    2015-08-06 21:45:54.700000003 +0000
@@ -6,4 +6,4 @@

 mkfs return value: 0
 fsck return value: 0
-9336eb47979f61e934c3aec3434333d7
+ffa06ab882e916a42abea58342256830
--- /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/expected/minix/fsck-images-v2c14  2015-08-06 21:28:12.917048708 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/output/minix/fsck-images-v2c14    2015-08-06 21:45:54.780000003 +0000
@@ -6,4 +6,4 @@

 mkfs return value: 0
 fsck return value: 0
-acfd4cae9ccfc3bc1a12d3c4a39f95c9
+3059480cac68cf9dfadff824fbddf435
--- /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/expected/minix/fsck-images-v2c30  2015-08-06 21:28:12.917048708 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/output/minix/fsck-images-v2c30    2015-08-06 21:45:54.840000003 +0000
@@ -6,4 +6,4 @@

 mkfs return value: 0
 fsck return value: 0
-1277a1e3a3cefa6afc63a9e38e4cfdf8
+ed40ea6abe47d1e26f7039bf8c044075
--- /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/expected/minix/fsck-images-v3c60  2015-08-06 21:28:12.917048708 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.rc1.git45.41e55/tests/output/minix/fsck-images-v3c60    2015-08-06 21:45:54.900000003 +0000
@@ -5,5 +5,8 @@
 Maxsize=2147483647

 mkfs return value: 0
-fsck return value: 0
-ca57b3604ed9476108ac41d1bdb1e1d5
+/: bad directory: '.' isn't first
+/: bad directory: '..' isn't second
+Inode 1 not used, marked used in the bitmap.
+fsck return value: 4
+907a34f3659b546a87ce10580c8f53cb
